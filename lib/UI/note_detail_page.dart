import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:todo_app/models/note_db.dart';
import 'package:todo_app/models/note_model.dart';

import 'add_notepage.dart';

class NoteDetailPage extends StatefulWidget {
  final NoteModel noteModel;
  final VoidCallback updateNoteList;
  NoteDetailPage({
    this.updateNoteList,
    this.noteModel,
  });

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  Notehelper notehelper = Notehelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffb716f2),
          child: Icon(Icons.edit),
          onPressed: () async {
            bool result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNotePage(
                          updateNoteList: () => widget.updateNoteList,
                          appBarTitle: 'Modify Notes',
                          note: widget.noteModel,
                        )));
            if (result == true) {
              setState(() {
                widget.updateNoteList();
              });
            }
          }),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                size: 28,
              ),
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share('${widget.noteModel.title}',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.content_copy,
                  size: 28,
                ),
                onPressed: () {
                  ClipboardManager.copyToClipBoard(widget.noteModel.title)
                      .then((result) {
                    Fluttertoast.showToast(
                        msg: 'Copied to Clipboard',
                        backgroundColor: Colors.black);
                  });
                }),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  if (widget.noteModel != null) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)),
                              title: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Delete Note',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.pink),
                                    ),
                                    Divider(thickness: 2,)
                                  ],
                                ),
                              ),
                              content: Text(
                                'The note will be deleted.',
                                style: Theme.of(context)
                                    .dialogTheme
                                    .titleTextStyle,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'cancel'.toUpperCase(),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    )),
                                FlatButton(
                                    onPressed: () async {
                                      await notehelper
                                          .deleteNote(widget.noteModel.id);
                                      setState(() {
                                        widget.updateNoteList();

                                        widget.noteModel.title = '';
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'ok'.toUpperCase(),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ))
                              ]);
                        });
                  }

                  return null;
                }),
          )
        ],
        backgroundColor: Color(0xffb716f2),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.noteModel.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
