import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/data/tasks.dart';

class TasksProvider with ChangeNotifier {
  List<Tasks> _tasks = [];
  int _nextId = 1;
  int _priorityTag = 0;
  SharedPreferences? _prefs;

  TasksProvider() {
    _loadTasksFromLocalStorage();
  }

  List<Tasks> get tasks => _tasks;

  void createNewTask(String title, int priority) {
    final newTasks = Tasks(
      id: _nextId,
      title: title,
      completed: false,
      priority: priority,
      categoryId: 1,
      createdAt: DateTime.now().toIso8601String(),
      dueDate: DateTime.now().toIso8601String(),
    );
    _priorityTag = priority;
    _tasks.add(newTasks);
    _nextId++;
    _saveTasksToLocalStorage();
    notifyListeners();
  }

  void updateTask(int id, String newTitle) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.title = newTitle;
    _saveTasksToLocalStorage();
    notifyListeners();
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasksToLocalStorage();
    notifyListeners();
  }

  void toggleTaskCompletion(int id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.completed = !task.completed;
    _saveTasksToLocalStorage();
    notifyListeners();
  }

  void updatePriorityTag(int id, int newPriority) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.priority = newPriority;
    _saveTasksToLocalStorage();
    notifyListeners();
  }

  void _loadTasksFromLocalStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final taskListAsJson = _prefs!.getStringList('tasks');

    if (taskListAsJson != null) {
      final taskList =
          taskListAsJson.map((jsonString) => json.decode(jsonString)).toList();
      _tasks = taskList
          .map((map) => Tasks.fromMap(Map<String, dynamic>.from(map)))
          .toList();
      _nextId = _prefs!.getInt('nextId') ?? 1;
      _priorityTag = _prefs!.getInt('priority') ?? 0;
      notifyListeners();
    }
  }

  void _saveTasksToLocalStorage() {
    if (_prefs != null) {
      final taskList = _tasks.map((task) => task.toMap()).toList();
      final taskListAsJson = taskList.map((map) => json.encode(map)).toList();
      _prefs!.setStringList('tasks', taskListAsJson);
      _prefs!.setInt('nextId', _nextId);
      _prefs!.setInt('priority', _priorityTag);
    }
  }
}
