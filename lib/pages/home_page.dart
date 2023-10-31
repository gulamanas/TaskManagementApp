import 'package:flutter/material.dart';
import 'package:task_management_app/pages/all_tasks_tab.dart';
import 'package:task_management_app/pages/finished_tasks_tab.dart';
import 'package:task_management_app/pages/unfinished_tasks_tab.dart';
import 'package:task_management_app/utils/create_task_dialog.dart';
import 'package:task_management_app/utils/side_navigation_drawer.dart';

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: addTaskButton(context),
      body: _tabs[_currentIndex],
      bottomNavigationBar: taskBottomNavigationBar(),
      drawer: const SideNavigationDrawer(),
    );
  }

  FloatingActionButton addTaskButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const CreateTaskDialog();
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  BottomNavigationBar taskBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}
