import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/priority_icon.dart';
import 'package:task_management_app/utils/priority_tag_dialog.dart';
import 'package:task_management_app/utils/priority_text.dart';

class TodoTile extends StatelessWidget {
  final int taskId;
  final bool isCompleted;
  final String title;
  final int priority;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const TodoTile({
    super.key,
    required this.taskId,
    required this.isCompleted,
    required this.title,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
            textAlign: TextAlign.start,
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
        ),
      ),
      Positioned(
        top: 5,
        right: 10,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: GestureDetector(
            onTap: () {
              showPriorityTagDialog(context, taskId, priority);
            },
            child: Row(
              children: [
               const Icon(
                  Icons.flag,
                  size: 16,
                ),
                getPriorityText(priority),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
