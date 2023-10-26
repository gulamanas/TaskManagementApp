import 'package:flutter/material.dart';

class Notes {
  int id;
  String title;
  bool completed;

  Notes({required this.id, required this.title, required this.completed});

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
