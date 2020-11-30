import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final contentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: contentController.text.isEmpty
              ? Container()
              : FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: Color(0xff301d8f),
                  label: Text(
                    'Save Note',
                    style: TextStyle(color: Colors.white),
                  ))),
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
    );
  }
}
