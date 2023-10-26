import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/data/notes.dart';
import 'package:task_management_app/providers/notes_provider.dart';
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
        title: const Text('Notes App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const CreateTaskDialog();
              }).then((newTaskTitle) {
            if (newTaskTitle != null) {
              Provider.of<NotesProvider>(context, listen: false)
                  .createNewTask(newTaskTitle);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, value, child) {
          final notes = value.notes;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: ((context, index) {
              final note = notes[index];
              return TodoTile(
                taskId: note.id,
                isCompleted: note.completed,
                title: note.title,
                onEditPressed: () {
                  updateTaskTitle(context, note);
                },
                onDeletePressed: () {
                  deleteTask(context, note);
                },
              );
            }),
          );
        },
      ),
    );
  }

  Future<dynamic> deleteTask(BuildContext context, Notes note) {
    return showDialog(
      context: context,
      builder: (context) {
        return DeleteTaskDialog(taskId: note.id);
      },
    );
  }

  Future<dynamic> updateTaskTitle(BuildContext context, Notes note) {
    return showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(
          taskId: note.id,
          currentTitle: note.title,
        );
      },
    );
  }
}
