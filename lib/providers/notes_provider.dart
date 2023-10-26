import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/data/notes.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notes = [];
  int _nextId = 1;
  SharedPreferences? _prefs;

  NotesProvider() {
    _loadNotesFromLocalStorage();
  }

  List<Notes> get notes => _notes;

  void createNewTask(String title) {
    final newNote = Notes(id: _nextId, title: title, completed: false);
    _notes.add(newNote);
    _nextId++;
    _saveNotesToLocalStorage();
    notifyListeners();
  }

  void updateTask(int id, String newTitle) {
    final note = _notes.firstWhere((note) => note.id == id);
    note.title = newTitle;
    _saveNotesToLocalStorage();
    notifyListeners();
  }

  void deleteTask(int id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotesToLocalStorage();
    notifyListeners();
  }

  void toggleTaskCompletion(int id) {
    final note = _notes.firstWhere((note) => note.id == id);
    note.completed = !note.completed;
    _saveNotesToLocalStorage();
    notifyListeners();
  }

  void _loadNotesFromLocalStorage() async {
    _prefs = await SharedPreferences.getInstance();
    // final notesList = _prefs!.getStringList('notes');
    final noteListAsJson = _prefs!.getStringList('notes');

    if (noteListAsJson != null) {
      final noteList =
          noteListAsJson.map((jsonString) => json.decode(jsonString)).toList();
      _notes = noteList
          .map((map) => Notes.fromMap(Map<String, dynamic>.from(map)))
          .toList();
      _nextId = _prefs!.getInt('nextId') ?? 1;
      notifyListeners();
    }
  }

  void _saveNotesToLocalStorage() {
    if (_prefs != null) {
      final noteList = _notes.map((note) => note.toMap()).toList();
      final noteListAsJson = noteList.map((map) => json.encode(map)).toList();
      _prefs!.setStringList('notes', noteListAsJson);
      _prefs!.setInt('nextId', _nextId);
    }
  }
}
