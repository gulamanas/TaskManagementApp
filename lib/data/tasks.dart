class Tasks {
  int id;
  String title;
  bool completed;
  int priority;

  Tasks({
    required this.id,
    required this.title,
    required this.completed,
    required this.priority,
  });

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
      priority: map['priority'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'priority': priority,
    };
  }
}
