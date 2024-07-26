import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/Todo_list_app/controller/todo_controller.dart';
import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(title: Text('TODO App')),
      body: Obx(() {
        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return Card(
              color: _getPriorityColor(todo.priority),
              child: ListTile(
                title: Text(todo.taskName),
                subtitle: Text(todo.note),
                trailing: IconButton(
                  icon: Icon(
                    todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  onPressed: () {
                    todo.isDone = !todo.isDone;
                    todoController.updateTodo(todo);
                  },
                ),
                onLongPress: () => todoController.deleteTodo(todo.id!),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, todoController),
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddTodoDialog(BuildContext context, TodoController controller) {
    final taskNameController = TextEditingController();
    final noteController = TextEditingController();
    int priority = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add TODO'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskNameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: 'Note'),
              ),
              DropdownButton<int>(
                value: priority,
                items: [
                  DropdownMenuItem(value: 1, child: Text('Low')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('High')),
                ],
                onChanged: (value) {
                  if (value != null) priority = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final todo = Todo(
                  taskName: taskNameController.text,
                  note: noteController.text,
                  priority: priority,
                );
                controller.addTodo(todo);
                Get.back();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
