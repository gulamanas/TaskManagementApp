import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/utils/dialog_box.dart';
import 'package:task_management_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getAllData();
    super.initState();
  }

  List todoList = [
    // ["Make Tutorial", false],
    // ["Do Exercises", false],
  ];

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
    saveTaskLocally();
  }

  void saveNewTask() {
    saveTaskLocally();

    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveTaskLocally() async {
    var prefs = await SharedPreferences.getInstance();
    String jsonTodoList = jsonEncode(todoList);

    prefs.setString('todoList', jsonTodoList);
  }

  void deleteTask(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow[300],
            content: const Text('Confirm Delete this Task?'),
            actions: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                    });
                    saveTaskLocally();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            onDelete: () => deleteTask(index),
          );
        },
        itemCount: todoList.length,
      ),
    );
  }

  void getAllData() async {
    var prefs = await SharedPreferences.getInstance();
    String jsonTodoList = prefs.getString('todoList') ?? "";

    var prefstodoList = jsonDecode(jsonTodoList);

    setState(() {
      todoList = prefstodoList ?? [];
    });
  }
}
