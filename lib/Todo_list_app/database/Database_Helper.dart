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

  // A getter that initializes the database if it hasn't been initialized yet,
  // otherwise returns the existing instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // A private method that initializes the database
  Future<Database> _initDb() async {
    //Retrieves the default database directory path for the app using getDatabasesPath()
    final dbPath = await getDatabasesPath();

    //Joins the directory path (dbPath) with the database name (todo.db) to form the full database path
    final path = join(dbPath, 'todo.db');

    /* Opens the database at the specified path. If the database does not exist,
    it creates it. The version parameter specifies the version of the database.
    The onCreate callback is executed when the database is created for the first time.
    */
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        /*
        Executes the SQL statement to create the todos table
        with columns: id, taskName, isDone, note, and priority.
        */
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
    final maps = await db.query('todos',
        orderBy: 'priority DESC'
    );
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
