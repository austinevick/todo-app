import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/note_database.dart';
import 'package:todo_app/models/note.dart';

class NoteProvider extends ChangeNotifier {
  final NoteDatabaseHelper noteDatabaseHelper = NoteDatabaseHelper();
  List<Note> noteList = [];

  fetchListOfNote() {
    Future<List<Note>> notes = noteDatabaseHelper.getNotes();
    notes.then((note) {
      noteList = note;
      notifyListeners();
    });
  }

  void addNote(Note note) {
    noteDatabaseHelper.saveNote(note);
  }
}
