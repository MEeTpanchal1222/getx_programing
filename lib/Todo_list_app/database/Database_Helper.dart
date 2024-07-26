import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modal/todo_modal.dart';

class DatabaseHelper {
  static final String databaseName = "todo.db";
  static final String tableName = "todos";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }



  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final fullPath = path.join(dbPath, databaseName);
    return await openDatabase(fullPath,
        version: 1, onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
        });
  }

  // CRUD operations with raw SQL queries

  //INSERT
  Future<int> insertNote(Todo Todo) async {
    final db = await database;
    final result = await db.rawInsert(
        '''INSERT INTO $tableName (title, content) VALUES (?, ?)''',
        [Todo.title, Todo.description]);
    return result;
  }

  // READ BY ID
  Future<Todo?> getNoteById(int id) async {
    final db = await database;
    final maps = await db.rawQuery(
        '''SELECT * FROM $tableName WHERE id = ?''', [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

// READ ALL DATA
  Future<List<Todo>> getAllNotes() async {
    final db = await database;
    final maps = await db.rawQuery('''SELECT * FROM $tableName''');
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

// UPDATE
  Future<int> updateNote(Todo Todo) async {
    final db = await database;
    final result = await db.rawUpdate(
        '''UPDATE $tableName SET title = ?, content = ? WHERE id = ?''',
        [Todo.title, Todo.description, Todo.id]);
    return result;
  }

// DELETE BY ID
  Future<int> deleteNote(int id) async {
    final db = await database;
    final result = await db.rawDelete(
        '''DELETE FROM $tableName WHERE id = ?''', [id]);
    return result;
  }



}