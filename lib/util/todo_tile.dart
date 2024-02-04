import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String title;
  final DateTime? dueDate;
  final String priority;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext?)? deleteFunction;
  ToDoTile({
    super.key,
    required this.title,
    required this.dueDate,
    required this.priority,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('MMM dd');
    TextStyle taskInfoStyle =
        TextStyle(color: Theme.of(context).hintColor, fontSize: 11);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Expanded(
                child: ClipRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          dueDate != null
                              ? Text(
                                  'Due: ${dateFormat.format(dueDate!)}',
                                  style: taskInfoStyle,
                                )
                              : const SizedBox(
                                  height: 1,
                                ),
                          priority.isNotEmpty
                              ? Text(
                                  ' · Priority: $priority',
                                  style: taskInfoStyle,
                                )
                              : const SizedBox(
                                  height: 1,
                                ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
