import 'package:getx_programing/Todo_list_app/modal/todo_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/* Ensures that there's only one instance of DatabaseHelper across the entire app.*/

class DatabaseHelper {
  //Singleton Pattern
  //Declares a variable named _instance of type DatabaseHelper;
  //This part initializes _instance with a new DatabaseHelper object.
  // The _internal() constructor is a named private constructor used to create the instance.
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  //when the  class call the it returns the existing _instance created earlier.
  // This ensures that only one instance of DatabaseHelper is used throughout the app
  factory DatabaseHelper() => _instance;

  // _database: A static variable to hold the instance of the SQFLite database.
  static Database? _database;

  //_internal is a named private constructor used to create the instance of DatabaseHelper.
  DatabaseHelper._internal();


  //Database Initialization

  // A getter that initializes the database if it
  // hasn't been initialized yet, otherwise returns the existing instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // A private method that initializes the database
  Future<Database> _initDb() async {
    //getDatabasesPath(): Retrieves the default database directory path for the app.
    final dbPath = await getDatabasesPath();//
    //join(dbPath, 'todo.db'): Joins the directory path with the database name todo.db.
    final path = join(dbPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskName TEXT,
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
    final maps = await db.query('todos');
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
