import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/pages/all_tasks_tab.dart';
import 'package:task_management_app/pages/finished_tasks_tab.dart';
import 'package:task_management_app/pages/unfinished_tasks_tab.dart';
import 'package:task_management_app/providers/tasks_provider.dart';
import 'package:task_management_app/utils/create_task_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    AllTasksTab(),
    FinishedTasksTab(),
    UnfinishedTasksTab(),
  ];

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
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Finished'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Unfinished'),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
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

  // Future<dynamic> updateTaskTitle(BuildContext context, Tasks task) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return EditTaskDialog(
  //         taskId: task.id,
  //         currentTitle: task.title,
  //       );
  //     },
  //   );
  // }
}
