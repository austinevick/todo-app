import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/taskModel.dart';

class TodoHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String DATE = 'date';
  static const String COMPLETED = 'completed';
  static const String TIME = 'time';
  static const String TABLE = 'todo';
  static const String DB_NAME = 'todo.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      // if database does not exist create a new one
      _db = await initDB();
      return _db;
    }
  }

  initDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: createDB);
    return db;
  }

  createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT, $DATE TEXT, $TIME TEXT, $COMPLETED INTEGER)');
  }

  Future<TaskModel> insertTodo(TaskModel todo) async {
    var db = await this.db;
    todo.id = await db.insert(TABLE, todo.toMap());
    return todo;
  }

  Future<List<TaskModel>> getTodo() async {
    var db = await this.db;
    List<Map> maps = await db.query(TABLE, columns: [ID, TITLE, DATE, TIME, COMPLETED]);
    List<TaskModel> todoList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        todoList.add(TaskModel.fromMap(maps[i]));
      }
    }
    todoList.sort((a, b) => a.date.compareTo(b.date));
    return todoList;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.db;
    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }
  Future<int> deleteAllTask()async{
    var db = await this.db;
    return await db.delete(TABLE);
     }

  Future<int> updateTodo(TaskModel todo) async {
    var db = await this.db;
    return await db.update(TABLE, todo.toMap(),
        whereArgs: [todo.id], where: '$ID = ?');
  }

  Future close() async {
    var db = await this.db;
    db.close();
  }
}
