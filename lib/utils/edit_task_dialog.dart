import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

Future<dynamic> showUpdateTaskTitleDialog(
    BuildContext context, int taskId, String taskTitle) {
  final taskTitleController = TextEditingController(text: taskTitle);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: taskTitleController,
          decoration: const InputDecoration(labelText: 'Task Title'),
          maxLines: null,
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
                final taskProvider =
                    Provider.of<TasksProvider>(context, listen: false);
                taskProvider.updateTask(taskId, newTaskTitle);
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
