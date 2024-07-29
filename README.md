# TODO APP USING DATABASE



## Overview

This Flutter application is a Todo List App that uses GetX for state management and Sqflite for local database operations. The app allows users to add, update, delete, and retrieve todo tasks. Each task has a priority level, and tasks with higher priority are displayed at the top of the list.

## Features
```Add Todo```: Users can add new tasks with a name, note, and priority level.


```Delete Todo```: Users can delete tasks.

```List Todos```: Tasks are listed with the highest priority tasks displayed at the top.

```Priority Levels```: Tasks can be assigned a priority level of Low, Medium, or High.

## Technologies Used
```GetX```: State management solution.

```Sqflite```: SQLite plugin for Flutter, used for local database operations.

## Example Code

### TodoController
 ``` dart
import 'package:get/get.dart';
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
```
### DatabaseHelper
``` dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskName TEXT NOT NULL,
            isDone INTEGER,
            note TEXT,
            priority INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos', orderBy: 'priority DESC');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

```
### AddTodoDialog
``` dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_programing/Todo_list_app/controllers/todo_controller.dart';
import 'package:getx_programing/Todo_list_app/models/todo_model.dart';

void _showAddTodoDialog(BuildContext context, TodoController controller) {
  final taskNameController = TextEditingController();
  final noteController = TextEditingController();
  final RxInt priority = controller.priority.value.obs;

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
            Obx(() {
              return DropdownButton<int>(
                value: priority.value,
                items: [
                  DropdownMenuItem(value: 0, child: Text('Default')),
                  DropdownMenuItem(value: 1, child: Text('Low')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('High')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    priority.value = value;
                  }
                },
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final todo = Todo(
                taskName: taskNameController.text,
                note: noteController.text,
                priority: priority.value,
              );
              controller.addTodo(todo);
              Get.back();
            },
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      );
    },
  );
}

```
## video

https://github.com/user-attachments/assets/72735969-a2a8-4bd6-b4d9-be47d9a62a1e

## License
This project is licensed under the MIT License - see the LICENSE file for details.


