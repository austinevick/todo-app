import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/provider/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final contentController = new TextEditingController();
  final titleController = new TextEditingController();

  final picker = ImagePicker();
  File imageFile;
  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() => imageFile = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff301d8f),
            onPressed: () {
              final bytes = imageFile.readAsBytesSync();
              Note note = new Note(
                date: DateFormat.yMMMd().add_Hm().format(DateTime.now()),
                image: base64Encode(bytes),
                title: titleController.text,
                content: contentController.text,
              );
              provider.addNote(note);
              provider.fetchListOfNote();
              print(note);
            },
            child: Icon(
              Icons.done,
              color: Colors.white,
            )),
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Add image',
                    style: TextStyle(
                      fontSize: 18,
                    )))
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
