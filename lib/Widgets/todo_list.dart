class TodoList {
  String? id;
  String? todoText;
  bool isDone;

  TodoList({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  // Create a static method to return a list of sample todos
  static List<TodoList> todoList() {
    return [
      TodoList(id: '01', todoText: 'Morning exercise', isDone: true),
      TodoList(id: '02', todoText: 'Evening exercise', isDone: true),
      TodoList(id: '03', todoText: 'Buy groceries'),
      TodoList(id: '04', todoText: 'Study Flutter'),
    ];
  }

  // Convert a TodoList object into a JSON format (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  // Convert a JSON object (Map<String, dynamic>) back into a TodoList object
  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      id: json['id'] as String?,
      todoText: json['todoText'] as String?,
      isDone: json['isDone'] as bool,
    );
  }
}
