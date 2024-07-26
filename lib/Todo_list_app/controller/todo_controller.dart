import 'package:get/get.dart';
import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';

class TodoController extends GetxController {
  //todo list
  var todos = <Todo>[].obs;

  //create
  void addTodo(Todo todo) {
    todos.add(todo);
  }

  // Read
  List<Todo> get allTodos => todos;

  // Update
  void updateTodo(int id, String title, String description) {
    var todo = todos.firstWhere((todo) => todo.id == id);
    todo.title = title;
    todo.description = description;
    todos.refresh();
  }

  // Delete
  void deleteTodo(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }
}
