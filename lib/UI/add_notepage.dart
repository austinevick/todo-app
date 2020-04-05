import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:todo_app/UI/note_detail_page.dart';
import 'package:todo_app/UI/notekeeper_page.dart';
import 'package:todo_app/models/note_db.dart';
import 'package:todo_app/models/note_model.dart';

class AddNotePage extends StatefulWidget {
   final String appBarTitle;
  final NoteModel note;
  final Function updateNoteList;
  AddNotePage({this.note, this.updateNoteList,this.appBarTitle});
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  Notehelper notehelper;
   SpeechRecognition _speechRecognition;
   bool _isAvailable = false;
  bool _isListening = false;

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note.title;
    }
    notehelper = Notehelper();
    initSpeechRecognizer();
    super.initState();
  }


 void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));
    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));
    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => titleController.text = speech));
    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));
    _speechRecognition
        .activate()
        .then((result) => setState(() => _isAvailable = result));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           if (_isAvailable && !_isListening) {
                _speechRecognition
                    .listen(locale: "en_US")
                    .then((result) => print(result));}
        },
        child: Icon(Icons.mic),
        backgroundColor: Color(0xffb716f2),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffb716f2),
        title: Text(widget.appBarTitle),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.done,
                  size: 30,
                ),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    print(titleController.text);
                    NoteModel noteModel =
                        NoteModel(title: titleController.text);
                    if (widget.note == null) {
                      notehelper.insertNote(noteModel);
                      Fluttertoast.showToast(msg: 'Note Saved');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotekeeperPage()));
                    } else {
                      noteModel.id = widget.note.id;
                      notehelper.updateNote(noteModel);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteDetailPage(
                                    noteModel: noteModel,
                                    updateDetailPage: widget.updateNoteList,
                                  )));
                    }

                    widget.updateNoteList();
                  }
                }),
          )
        ],
      ),
      body: Container(
          child: Form(
            
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 100,
                  validator: (value) {
                    if (value.isEmpty) {
                      Fluttertoast.showToast(msg: 'Text must not be null' );
                      return '';
                      
                    }
                    return null;
                  },
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your note here'),
                ),
              ))),
    );
  }
}
