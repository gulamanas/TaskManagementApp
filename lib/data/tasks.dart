class Tasks {
  int id;
  String title;
  bool completed;
  int priority;
  int categoryId;
  String createdAt;
  String dueDate;

  Tasks({
    required this.id,
    required this.title,
    required this.completed,
    required this.priority,
    required this.categoryId,
    required this.createdAt,
    required this.dueDate,
  });

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
      priority: map['priority'] as int,
      categoryId: map['categoryId'] ?? 0,
      createdAt: map['createdAt'] ?? DateTime.now().toIso8601String(),
      dueDate: map['dueDate'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'priority': priority,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'dueDate': dueDate,
    };
  }
}
