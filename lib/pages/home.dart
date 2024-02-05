import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todone_app/generated/l10n.dart';
import 'package:todone_app/util/dialog_box.dart';
import 'package:todone_app/util/empty_list_view.dart';
import 'package:todone_app/util/todo_tile.dart';
import 'package:todone_lib/todone_lib.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDone parser = ToDone();
  late String tasksPath;
  List<Task> tasks = [];

  void _checkBoxChanged(bool value, int index) {
    setState(() {
      tasks[index].doneDate = DateTime.now();
      tasks[index].status = value ? Status.done : Status.undone;
      parser.writeToFilePath(tasksPath, tasks);
    });
  }

  bool _isTaskCompleted(int index) {
    return tasks[index].status == Status.done ? true : false;
  }

  Future<void> getPaths() async {
    final Directory configDir = await getApplicationSupportDirectory();
    final Directory docsDir;
    if (Platform.isAndroid) {
      docsDir = (await getExternalStorageDirectory())!;
    } else {
      docsDir = await getApplicationDocumentsDirectory();
    }

    if (File('${configDir.path}/config.json').existsSync()) {
      String configString =
          File('${configDir.path}/config.json').readAsStringSync();
      var config = jsonDecode(configString);
      tasksPath = config['tasksPath'];
    } else {
      File('${configDir.path}/config.json').createSync(recursive: true);
      String configString =
          '{ "tasksPath": "${docsDir.path}/ToDone/tasks.todo" }';
      File('${configDir.path}/config.json').writeAsStringSync(configString);
      tasksPath = '${docsDir.path}/ToDone/tasks.todo';
    }

    if (!File(tasksPath).existsSync()) {
      File(tasksPath).createSync(recursive: true);
    }

    tasks = parser.parseTasksFromPath(tasksPath);
  }

  final _controller = TextEditingController();

  void saveNewTask(DateTime? dueDate) {
    Task task = Task(_controller.text);
    task.creationDate = DateTime.now();
    task.dueDate = dueDate;
    tasks.add(task);
    parser.writeToFilePath(tasksPath, tasks);
    Navigator.of(context).pop();
    setState(() {});
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: (DateTime? dueDate) => (saveNewTask(dueDate)),
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    _controller.clear();
  }

  void _deleteTask(int index) {
    tasks.removeAt(index);
    parser.writeToFilePath(tasksPath, tasks);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPaths().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDone App'),
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          tasks = parser.parseTasksFromPath(tasksPath);
          setState(() {});
          return Future<void>.delayed(const Duration(seconds: 0));
        },
        child: tasks.isEmpty
            ? EmptyListView(
                title: S.current.emptyList,
                description: S.current.emptyListDescription,
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    title: tasks[index].title,
                    dueDate: tasks[index].dueDate,
                    priority: tasks[index].priority,
                    taskCompleted: _isTaskCompleted(index),
                    onChanged: (value) => _checkBoxChanged(value!, index),
                    deleteFunction: (value) => _deleteTask(index),
                  );
                },
              ),
      ),
    );
  }
}
