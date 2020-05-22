import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/models/note_db.dart';
import 'package:todo_app/models/note_model.dart';

class AddNotePage extends StatefulWidget {
  static const String id = 'add_note_page';
  final String appBarTitle;
  final NoteModel note;
  final Function updateNoteList;

  AddNotePage({this.note, this.updateNoteList, this.appBarTitle});
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  Notehelper notehelper = Notehelper();

  insertAndUpdateNote() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      NoteModel noteModel = NoteModel(title: titleController.text);
      if (widget.note == null) {
        notehelper.insertNote(noteModel);
        widget.updateNoteList();
        Navigator.pop(context);
      } else {
        notehelper.updateNote(noteModel);

        Navigator.pop(context, true);
        widget.updateNoteList();
      }
    }
  }

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertAndUpdateNote();
        },
        child: Icon(
          Icons.done,
          size: 30,
        ),
        backgroundColor: Color(0xffb716f2),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffb716f2),
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      body: Container(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 100,
                  validator: (value) {
                    if (value.isEmpty) {
                      Fluttertoast.showToast(msg: 'Text must not be null');
                      return '';
                    }
                    return null;
                  },
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your note here'),
                ),
              ))),
    );
  }
}
