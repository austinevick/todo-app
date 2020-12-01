import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/note_provider.dart';
import 'package:todo_app/screens/add_note_screen.dart';
import 'package:todo_app/widgets/add_button.dart';

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
        backgroundColor: Colors.black,
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
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            var note = noteList.noteList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                color: Color(0xff301d8f),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        note.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        note.content,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: noteList.noteList.length,
          staggeredTileBuilder: (index) => StaggeredTile.count(
              (index % 5 == 0) ? 3 : 1, (index % 5 == 0) ? 1 : 1),
        ),
      ),
    );
  }
}
