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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime? dueDate;
    TextEditingController dueDateController = TextEditingController();
    DateFormat dueDateFormat = DateFormat('EEE d MMM');
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: S.current.title,
                  hintText: S.current.addNewTask),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return S.current.titleCannotBeEmpty;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
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
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: ActionButton(
                    text: S.current.save,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onSave(dueDate);
                      }
                    },
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
