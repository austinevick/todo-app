import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/UI/add_notepage.dart';
import 'package:todo_app/UI/note_detail_page.dart';
import 'package:todo_app/UI/todoList_page.dart';
import 'package:todo_app/models/note_db.dart';
import 'package:todo_app/models/note_model.dart';

class NotekeeperPage extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _NotekeeperPageState createState() => _NotekeeperPageState();
}

class _NotekeeperPageState extends State<NotekeeperPage> {
  final prefs = SharedPreferences.getInstance();
  save(key, value)async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }
  restore()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      showGridView = (preferences.getBool('showGridView')?? false);
    });
  }
  List<NoteModel> noteList = List<NoteModel>();
  Notehelper notehelper = Notehelper();
  bool showGridView = true;
  void onToggle() {
    setState(() {
      showGridView = !showGridView;
    });
    save('showGridView', showGridView);
  }

  updateNoteList() {
    Future<List<NoteModel>> notes = notehelper.getNote();
    notes.then((note) {
      setState(() {
        this.noteList = note;
      });
    });
  }

  @override
  void initState() {
    restore();
    updateNoteList();
    super.initState();
  }

  deleteAllNotefromList() {
    if (noteList.length > 0) {
      return showDialog(
          context: (context),
          builder: (context) {
            return AlertDialog(
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
                title: Center(
                  child: Text(
                    'Delete All Notes',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                content: Text(
                  'Are you sure you want to delete all notes',
                  style: Theme.of(context).dialogTheme.titleTextStyle,
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline6)),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        notehelper.deleteAllNote();
                        setState(() {
                          updateNoteList();
                        });
                      },
                      child: Text(
                        'Yes'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6,
                      ))
                ]);
          });
    } else {
      Fluttertoast.showToast(msg: 'No notes to delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   drawer: buildDrawer(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffb716f2),
            child: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNotePage(
                            updateNoteList: () => updateNoteList(),
                            appBarTitle: 'Add Notes',
                          )));
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color(0xffb716f2),
          title: Text('Notes'),
          actions: <Widget>[
            IconButton(
                icon: showGridView == true
                    ? Icon(
                        Icons.grid_on,
                        size: 26,
                      )
                    : Icon(
                        Icons.list,
                        size: 30,
                      ),
                onPressed: onToggle),
            IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  size: 30,
                ),
                onPressed: () {
                  deleteAllNotefromList();
                }),
          ],
        ),
        body: buildBody());
  }

  buildBody() {
    if (showGridView == true && noteList.length != null) {
      return Center(
          child: GridView.builder(
              itemCount: noteList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(noteList[index].id),
                  onDismissed: (direction) {
                    notehelper.deleteNote(noteList[index].id);
                    updateNoteList();
                    Fluttertoast.showToast(msg: 'Note deleted successfully');
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        noteList[index].isSelected = true;
                      });
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteDetailPage(
                                    updateNoteList: () => updateNoteList(),
                                    noteModel: noteList[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              noteList[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    ),
                  ),
                  background: Icon(
                    Icons.delete,
                    size: 50,
                    color: Colors.red,
                  ),
                );
              }));
    } else if (showGridView == false && noteList.length != null) {
      return ListView.builder(
          itemCount: noteList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(noteList[index].id),
              onDismissed: (direction) {
                notehelper.deleteNote(noteList[index].id);
                updateNoteList();
                Fluttertoast.showToast(msg: 'Note deleted successfully');
              },
              child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      noteList[index].isSelected = true;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteDetailPage(
                                  updateNoteList: () => updateNoteList(),
                                  noteModel: noteList[index],
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          noteList[index].title,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  )),
              background: Icon(
                Icons.delete,
                size: 50,
                color: Colors.red,
              ),
            );
          });
    } else if (noteList.length < 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/note_icon.jpg'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No Notes',
                style: TextStyle(
                    fontSize: 30, color: Colors.grey.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      );
    }
  }

  buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('asset/app_icon.jpg'))),
            ),
            decoration: BoxDecoration(color: Color(0xff3f51b5)),
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Color(0xff3f51b5),
            ),
            title: Text(
              'Add Tasks',
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TodoListPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Color(0xff3f51b5),
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Color(0xff3f51b5),
            ),
            title: Text(
              'Share',
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: Color(0xff3f51b5),
            ),
            title: Text(
              'Contact us',
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
