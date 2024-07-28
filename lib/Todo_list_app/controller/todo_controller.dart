import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:getx_programing/Todo_list_app/database/Database_Helper.dart';
import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  RxInt priority = 0.obs;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    todos.value = await dbHelper.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await dbHelper.insertTodo(todo);
    loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await dbHelper.updateTodo(todo);
    loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await dbHelper.deleteTodo(id);
    loadTodos();
  }
}
