import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed: contentController.text.isEmpty
                    ? null
                    : () {
                        //Navigator.of(context).pop();

                        showDialog(
                            context: context,
                            builder: (ctx) => Dialog(
                                  child: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Enter title to save',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                              hintText: 'Title'),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('CANCEL')),
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Note note = new Note(
                                                        content:
                                                            contentController
                                                                .text,
                                                        date: DateFormat.yMEd()
                                                            .format(
                                                                DateTime.now()),
                                                        title: titleController
                                                            .text);
                                                    provider.addNote(note);
                                                    provider.fetchListOfNote();
                                                  },
                                                  child: Text('SAVE'))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                child: Text('Save Note', style: TextStyle(fontSize: 18)))
          ],
        ),
        body: Container(
          child: Column(
            children: [
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
      ),
    );
  }
}
