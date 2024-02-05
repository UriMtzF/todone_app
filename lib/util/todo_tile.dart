import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todone_app/generated/l10n.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String title;
  final DateTime? dueDate;
  final String priority;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext?)? deleteFunction;
  Function()? editFunciton;
  ToDoTile({
    super.key,
    required this.title,
    required this.dueDate,
    required this.priority,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunciton,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat(
      'MMM d',
      Localizations.localeOf(context).languageCode,
    );
    TextStyle taskInfoStyle =
        TextStyle(color: Theme.of(context).hintColor, fontSize: 11);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
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
                          for (var condition in [
                            if (dueDate != null)
                              '${S.current.due}: ${dateFormat.format(dueDate!)}',
                            if (priority.isNotEmpty && dueDate != null)
                              ' · ${S.current.priority}: $priority',
                            if (priority.isNotEmpty && dueDate == null)
                              '${S.current.priority}: $priority',
                          ])
                            Text(
                              condition,
                              style: taskInfoStyle,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: editFunciton,
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
