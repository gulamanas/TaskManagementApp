import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

class EditTaskDialog extends StatefulWidget {
  final int taskId;
  final String currentTitle;
  const EditTaskDialog({
    super.key,
    required this.taskId,
    required this.currentTitle,
  });

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController taskTitleController;

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController(text: widget.currentTitle);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Edit Task",
      ),
      content: TextField(
        controller: taskTitleController,
        decoration: const InputDecoration(labelText: "Task Title"),
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
              final tasksProvider =
                  Provider.of<TasksProvider>(context, listen: false);
              tasksProvider.updateTask(widget.taskId, newTaskTitle);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
