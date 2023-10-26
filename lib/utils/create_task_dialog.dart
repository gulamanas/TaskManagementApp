import 'package:flutter/material.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskTitleController = TextEditingController();
    return AlertDialog(
      title: const Text("Create a New Task"),
      content: TextField(
        controller: taskTitleController,
        decoration: const InputDecoration(labelText: "Task Title"),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newTaskTitle = taskTitleController.text;
            if (newTaskTitle.isNotEmpty) {
              Navigator.of(context).pop(newTaskTitle);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
