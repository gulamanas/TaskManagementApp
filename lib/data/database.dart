import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    todoList = [
      ["Make Tutorial", false],
      ["Do Exercises", false],
    ];
  }

// load data from the database
  void loadData () {
    todoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDataBase () {
    _myBox.put('TODOLIST', todoList);
  }
}
