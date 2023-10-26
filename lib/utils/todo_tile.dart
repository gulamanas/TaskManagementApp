import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

class TodoTile extends StatelessWidget {
  final int taskId;
  final bool isCompleted;
  final String title;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const TodoTile({
    super.key,
    required this.taskId,
    required this.isCompleted,
    required this.title,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        activeColor: Colors.black,
        onChanged: (value) {
          final tasksProvider =
              Provider.of<TasksProvider>(context, listen: false);
          tasksProvider.toggleTaskCompletion(taskId);
        },
      ),
      title: Text(
        title,
        style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit),
            color: Colors.blue[400],
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
            color: Colors.red[400],
          ),
        ],
      ),
    );
  }
}
