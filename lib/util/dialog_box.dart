import 'package:flutter/material.dart';
import 'package:todone_app/util/action_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: ActionButton(text: 'Save', onPressed: onSave),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: ActionButton(text: 'Cancel', onPressed: onCancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
