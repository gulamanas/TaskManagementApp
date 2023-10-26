import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

class DeleteTaskDialog extends StatelessWidget {
  final int taskId;
  const DeleteTaskDialog({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Do you want to delete this Task?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () {
            final tasksProvider =
                Provider.of<TasksProvider>(context, listen: false);
            tasksProvider.deleteTask(taskId);
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
