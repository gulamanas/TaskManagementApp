import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/data/database.dart';
import 'package:task_management_app/utils/dialog_box.dart';
import 'package:task_management_app/utils/todo_tile.dart';
import 'package:task_management_app/utils/todo_shared_preff.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // if this is the 1st time ever opening the app
    // if (_myBox.get('TODOLIST') == null) {
    //   db.createInitialData();
    // } else {
    //   // there already exists data
    //   db.loadData();
    // }
    getAllData();
    super.initState();
  }

  List todoList = [
    // ["Make Tutorial", false],
    // ["Do Exercises", false],
  ];
  // reference the hive box
  // final _myBox = Hive.box('mybox');

  // text controller
  final _controller = TextEditingController();

  // * TodoDatabase db = TodoDatabase();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
    saveTaskLocally();
    // db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    saveTaskLocally();

    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    // db.updateDataBase();
  }

  // create a new task
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
    setState(() {
      todoList.removeAt(index);
    });
    saveTaskLocally();
    // db.updateDataBase();
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
