import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/note_model.dart';

class Notehelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String TABLE = 'notekeeper';
  static const String DB_NAME = 'note.db';

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
        'CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT)');
  }

  Future<NoteModel> insertNote(NoteModel note) async {
    var db = await this.db;
    note.id = await db.insert(TABLE, note.toMap());
    return note;
  }

  Future<List<NoteModel>> getNote() async {
    var db = await this.db;
    List<Map> maps = await db.query(TABLE, columns: [ID, TITLE]);
    List<NoteModel> noteList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        noteList.add(NoteModel.fromMap(maps[i]));
      }
    }
    noteList.sort((a, b) => a.title.compareTo(b.title));
    return noteList;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.db;
    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> deleteAllNote() async {
    var db = await this.db;
    return await db.delete(TABLE);
  }

  Future<int> updateNote(NoteModel note) async {
    var db = await this.db;
    return await db.update(TABLE, note.toMap(),
        whereArgs: [note.id], where: '$ID = ?');
  }

  Future close() async {
    var db = await this.db;
    db.close();
  }
}
