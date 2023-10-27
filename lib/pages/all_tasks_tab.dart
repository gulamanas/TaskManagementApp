import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/delete_task_dialog.dart';
import 'package:task_management_app/utils/edit_task_dialog.dart';
import 'package:task_management_app/utils/todo_tile.dart';

class AllTasksTab extends StatelessWidget {
  const AllTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, value, child) {
        final tasks = value.tasks;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: ((context, index) {
            final task = tasks[index];
            return TodoTile(
              taskId: task.id,
              isCompleted: task.completed,
              title: task.title,
              priority: task.priority,
              onEditPressed: () {
                // updateTaskTitle(context, task);
                showUpdateTaskTitleDialog(context, task.id, task.title);
              },
              onDeletePressed: () {
                showDeleteConfirmationDialog(context, task.id);
                // deleteTask(context, task);
              },
            );
          }),
        );
      },
    );
  }
}
