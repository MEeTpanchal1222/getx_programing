import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/Todo_list_app/controller/todo_controller.dart';
import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';

class TodoApp extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Todo's"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: todoController.allTodos.length,
                itemBuilder: (context, index) {
                  final todo = todoController.allTodos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        todoController.deleteTodo(todo.id);
                      },
                    ),
                    onTap: () {
                      _showUpdateDialog(context, todo);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final id = DateTime.now().millisecondsSinceEpoch;
                final todo = Todo(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                );
                todoController.addTodo(todo);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                todoController.updateTodo(
                  todo.id,
                  titleController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}