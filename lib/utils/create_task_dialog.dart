import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/tasks_provider.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskTitleController = TextEditingController();
    int selectedPriority = 0;

    return AlertDialog(
      title: const Text("Create a New Task"),
      content: Column(
        children: [
          TextField(
            controller: taskTitleController,
            decoration: const InputDecoration(labelText: "Task Title"),
          ),
          DropdownButtonFormField(
            value: selectedPriority,
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
            onChanged: (int? newValue) {
              if (newValue != null) {
                selectedPriority = newValue;
              }
            },
          ),
        ],
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
              Provider.of<TasksProvider>(context, listen: false)
                  .createNewTask(newTaskTitle, selectedPriority);
              Navigator.of(context).pop();
              // Navigator.of(context).pop([newTaskTitle, selectedPriority]);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
