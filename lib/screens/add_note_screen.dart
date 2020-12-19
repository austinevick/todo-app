import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/provider/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note note;

  const AddNoteScreen({Key key, this.note}) : super(key: key);
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final contentController = new TextEditingController();
  final titleController = new TextEditingController();
  var date = DateFormat.yMMMd().add_Hm().format(DateTime.now());

  final picker = ImagePicker();
  File imageFile;
  Uint8List bytes;
  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
      bytes = imageFile.readAsBytesSync();
    });
  }

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
      date = widget.note.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff301d8f),
            onPressed: () {
              Note note = new Note(
                  date: date,
                  //image: base64Encode(bytes),
                  title: titleController.text,
                  content: contentController.text);
              if (widget.note == null) {
                provider.addNote(note);
              } else {
                note.id = widget.note.id;
                provider.updateNote(note);
              }
              provider.fetchListOfNote();
              Navigator.of(context).pop();
              print(note);
            },
            child: Icon(
              Icons.done,
              color: Colors.white,
            )),
        appBar: AppBar(
          actions: [
            widget.note != null
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Navigator.of(context).pop();
                      provider.deleteNote(widget.note.id);
                      provider.fetchListOfNote();
                    })
                : Container()
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textCapitalization: TextCapitalization.sentences,
                      controller: titleController,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Title'),
                    ),
                  ),
                ),
                imageFile == null
                    ? SizedBox.shrink()
                    : Image.file(
                        imageFile,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                controller: contentController,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter new note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
