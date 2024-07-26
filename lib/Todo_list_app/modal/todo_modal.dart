class Todo {
  int? id;
  String taskName;
  bool isDone;
  String note;
  int priority;

  Todo({
    this.id,
    required this.taskName,
    this.isDone = false,
    required this.note,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'isDone': isDone ? 1 : 0,
      'note': note,
      'priority': priority,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      taskName: map['taskName'],
      isDone: map['isDone'] == 1,
      note: map['note'],
      priority: map['priority'],
    );
  }
}
