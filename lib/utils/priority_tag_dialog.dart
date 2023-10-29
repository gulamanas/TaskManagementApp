import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

Future<dynamic> showPriorityTagDialog(
    BuildContext context, int taskId, int priorityTag) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update Priority"),
        content: DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'Priority',
          ),
          value: priorityTag,
          items: const [
            DropdownMenuItem(
              value: 0,
              child: Text('None'),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text('Low'),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text('Medium'),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text('High'),
            ),
          ],
          onChanged: ((value) {
            if (value != null) {
              priorityTag = value;
            }
          }),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
              onPressed: () {
                final newPriorityTag = priorityTag;
                final taskProvider =
                    Provider.of<TasksProvider>(context, listen: false);
                taskProvider.updatePriorityTag(taskId, newPriorityTag);
                Navigator.of(context).pop();
              },
              child: const Text('Save'))
        ],
      );
    },
  );
}
