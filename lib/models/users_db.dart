import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/user_model.dart';

class UserHelper {
  static Database _db;
  static const String ID = 'id';
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
  static const String TABLE = 'users';
  static const String DB_NAME = 'user.db';

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
        'CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $USERNAME TEXT, $PASSWORD TEXT)');
  }

 Future<UserModel> insertTodo(UserModel user) async {
    var db = await this.db;
    user.id = await db.insert(TABLE, user.toMap());
    return user;
  }

Future<List<UserModel>> getUsers() async {
    var db = await this.db;
    List<Map> maps = await db.query(TABLE, columns: [ID, USERNAME, PASSWORD]);
    List<UserModel> usersList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        usersList.add(UserModel.fromMap(maps[i]));
      }
    }
    usersList.sort((a, b) => a.username.compareTo(b.username));
    return usersList;
  }

 Future<int> deleteUser(int id) async {
    var db = await this.db;
    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }
  Future<int> deleteAllUsers()async{
    var db = await this.db;
    return await db.delete(TABLE);
     }

Future<int> updateTodo(UserModel user) async {
    var db = await this.db;
    return await db.update(TABLE, user.toMap(),
        whereArgs: [user.id], where: '$ID = ?');
  }

  Future close() async {
    var db = await this.db;
    db.close();
  }


}
