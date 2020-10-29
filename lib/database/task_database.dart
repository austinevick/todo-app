import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class TaskDatabaseHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String TABLE = 'task';
  static const String DATE = 'date';
  static const String CATEGORIES = 'categories';
  static const String DB_NAME = 'task.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initializeDatabase();
    return _db;
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.path, DB_NAME);
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $CATEGORIES TEXT,$DATE TEXT)');
  }

  Future<Task> saveTask(Task task) async {
    var dbClient = await db;
    task.id = await dbClient.insert(
      TABLE,
      task.toMap(),
    );
    return task;
  }

  Future<List<Task>> getTasks() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      TABLE,
      columns: [ID, TITLE, DATE, CATEGORIES],
    );
    List<Task> taskList = [];
    if (maps != null) {
      for (var i = 0; i < maps.length; i++) {
        taskList.add(Task.fromMap(maps[i]));
      }
    }
    return taskList;
  }

  Future<int> deleteTask(int id) async {
    var dbClient = await db;
    return dbClient.delete(
      TABLE,
      where: '$ID = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTask(Task task) async {
    var dbClient = await db;
    return dbClient.update(
      TABLE,
      task.toMap(),
      where: '$ID = ?',
      whereArgs: [task.id],
    );
  }
}
