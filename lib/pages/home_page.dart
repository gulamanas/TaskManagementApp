import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/data/tasks.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/create_task_dialog.dart';
import 'package:task_management_app/utils/delete_task_dialog.dart';
import 'package:task_management_app/utils/edit_task_dialog.dart';
import 'package:task_management_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask(context).then((newTaskTitle) {
            if (newTaskTitle != null) {
              Provider.of<TasksProvider>(context, listen: false)
                  .createNewTask(newTaskTitle);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TasksProvider>(
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
                onEditPressed: () {
                  updateTaskTitle(context, task);
                },
                onDeletePressed: () {
                  deleteTask(context, task);
                },
              );
            }),
          );
        },
      ),
    );
  }

  Future<dynamic> createNewTask(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const CreateTaskDialog();
      },
    );
  }

  Future<dynamic> deleteTask(BuildContext context, Tasks task) {
    return showDialog(
      context: context,
      builder: (context) {
        return DeleteTaskDialog(taskId: task.id);
      },
    );
  }

  Future<dynamic> updateTaskTitle(BuildContext context, Tasks task) {
    return showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(
          taskId: task.id,
          currentTitle: task.title,
        );
      },
    );
  }
}
