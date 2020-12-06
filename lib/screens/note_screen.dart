import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/note_provider.dart';
import 'package:todo_app/screens/add_note_screen.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/note_list.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    Provider.of<NoteProvider>(
      context,
      listen: false,
    ).fetchListOfNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteList, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('All Note'),
            actions: [
              AddButton(
                  icon: Icons.add,
                  onTap: () => showBarModalBottomSheet(
                      context: context,
                      builder: (ctx, isScrolled) => AddNoteScreen()))
            ],
          ),
          body: NoteList(
            noteList: noteList.noteList,
          )),
    );
  }
}
