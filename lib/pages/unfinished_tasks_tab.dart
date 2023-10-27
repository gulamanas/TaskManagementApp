import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/delete_task_dialog.dart';
import 'package:task_management_app/utils/edit_task_dialog.dart';
import 'package:task_management_app/utils/todo_tile.dart';

class UnfinishedTasksTab extends StatelessWidget {
  const UnfinishedTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, value, child) {
        final tasks = value.tasks;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: ((context, index) {
            final task = tasks[index];
            if (task.completed) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            } else {
              return TodoTile(
                taskId: task.id,
                isCompleted: task.completed,
                title: task.title,
                priority: 0,
                onEditPressed: () {
                  showUpdateTaskTitleDialog(context, task.id, task.title);
                },
                onDeletePressed: () {
                  showDeleteConfirmationDialog(context, task.id);
                },
              );
            }
          }),
        );
      },
    );
  }
}
