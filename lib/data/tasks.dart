class Tasks {
  int id;
  String title;
  bool completed;

  Tasks({required this.id, required this.title, required this.completed});

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
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
