class Todo {
  int id;
  String title;
  String description;

  Todo({
    required this.id,
    required this.title,
    required this.description,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) => Todo(
    id: map['id'],
    title: map['title'],
    description: map['description'],
  );
}
