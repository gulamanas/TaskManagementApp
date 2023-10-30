import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/text_widgets.dart';

Future<dynamic> showDeleteConfirmationDialog(BuildContext context, int taskId) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Do you want to delete this Task?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: getElevatedButtonText('No'),
          ),
          ElevatedButton(
            onPressed: () {
              final tasksProvider =
                  Provider.of<TasksProvider>(context, listen: false);
              tasksProvider.deleteTask(taskId);
              Navigator.of(context).pop(true);
            },
            child: getElevatedButtonText('Yes'),
          ),
        ],
      );
    },
  );
}
