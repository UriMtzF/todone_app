import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todone_app/generated/l10n.dart';
import 'package:todone_app/util/action_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  Function(DateTime?) onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? dueDate;
    TextEditingController dueDateController = TextEditingController();
    var dueDateFormat = DateFormat('EEE d MMM');
    return AlertDialog(
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: S.current.addNewTask,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: dueDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: S.current.dueDate,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        currentDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        dueDate = selectedDate;
                        dueDateController.text =
                            dueDateFormat.format(selectedDate);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: ActionButton(
                    text: S.current.save,
                    onPressed: () => onSave(dueDate),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child:
                      ActionButton(text: S.current.cancel, onPressed: onCancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
