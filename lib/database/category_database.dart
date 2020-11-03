import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TaskCategoryHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String TABLE = 'taskCategory';
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
    await db
        .execute('CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT)');
  }
}
