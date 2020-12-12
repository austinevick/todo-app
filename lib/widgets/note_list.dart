import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/screens/add_note_screen.dart';

class NoteList extends StatelessWidget {
  final List<Note> noteList;

  const NoteList({Key key, this.noteList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        var note = noteList[index];
        return GestureDetector(
          onTap: () => showBarModalBottomSheet(
              context: context,
              builder: (ctx, isScrolled) => AddNoteScreen(
                    note: note,
                  )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff301d8f),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        note.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    note.image.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(base64Decode(
                                        note.image,
                                      )))),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        note.content,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: noteList.length,
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 5 == 0) ? 2 : 1, (index % 5 != 0) ? 2 : 1),
    );
  }
}
