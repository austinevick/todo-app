import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:todo_app/UI/notekeeper_page.dart';
import 'package:todo_app/models/note_db.dart';
import 'package:todo_app/models/note_model.dart';

import 'add_notepage.dart';

class NoteDetailPage extends StatefulWidget {
  static const String id = 'note_detail_page';
  final NoteModel noteModel;
  final Function updateDetailPage;
  NoteDetailPage({this.noteModel, this.updateDetailPage});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  Notehelper notehelper = Notehelper();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotekeeperPage())),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffb716f2),
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNotePage(
                            appBarTitle: 'Modify Notes',
                            note: widget.noteModel,
                            updateNoteList: () => widget.updateDetailPage(),
                          )));
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
                                  child: Text(
                                    'Delete Note',
                                    style: Theme.of(context).textTheme.title,
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
                                            Theme.of(context).textTheme.title,
                                      )),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotekeeperPage()));
                                        notehelper.deleteAllNote();
                                        widget.noteModel.title = '';
                                        setState(() {
                                          widget.updateDetailPage();
                                        });
                                      },
                                      child: Text(
                                        'ok'.toUpperCase(),
                                        style:
                                            Theme.of(context).textTheme.title,
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
      ),
    );
  }
}
