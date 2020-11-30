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
      appBar: AppBar(
        actions: [
          AnimatedSwitcher(
              duration: Duration(seconds: 2),
              child: contentController.text.isEmpty
                  ? Container()
                  : FlatButton(
                      onPressed: () {
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
                                              GestureDetector(
                                                child: Container(
                                                  child: Text('CANCEL'),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  child: Text('SAVE'),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      child: Text('Save Note', style: TextStyle(fontSize: 18))))
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
    );
  }
}
