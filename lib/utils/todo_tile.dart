import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/notes_provider.dart';

class TodoTile extends StatelessWidget {
  final taskId;
  final bool isCompleted;
  final String title;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  TodoTile({
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
        onChanged: (value) {
          final notesProvider =
              Provider.of<NotesProvider>(context, listen: false);
          notesProvider.toggleTaskCompletion(taskId);
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
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
