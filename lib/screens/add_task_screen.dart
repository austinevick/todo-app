import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Task task;

  const AddTaskScreen({Key key, this.task}) : super(key: key);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = new TextEditingController();
  var currentTime = DateFormat('HH:mm').format(DateTime.now());
  var items = ['one', 'two', 'three'];
  String initialValue = 'one';

  @override
  void initState() {
    if (widget.task != null) {
      titleController.text = widget.task.title;
      currentTime = widget.task.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Consumer<TaskProvider>(
        builder: (context, tasks, child) => Container(
          height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add task',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a title' : null,
                    cursorWidth: 1.5,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    controller: titleController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Title'),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        onPressed: () async {
                          var time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() => currentTime = time.format(context));
                          }
                        },
                        child: Icon(
                          Icons.timer,
                          size: 30,
                        )),
                    Text(
                      '$currentTime',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButton(
                        value: initialValue,
                        items: items
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() => initialValue = value);
                        }),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonBar(
                  buttonHeight: 45,
                  buttonMinWidth: 115,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        color: Colors.green,
                        width: 100,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              tasks.deleteTask(widget.task.id);
                              tasks.fetchTask();
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(fontSize: 20),
                            ))),
                    Container(
                        color: Colors.green,
                        width: 100,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Task task = new Task(
                                  title: titleController.text,
                                  date: currentTime);
                              if (widget.task == null) {
                                task.complete = 0;
                                tasks.addTask(task);
                                print(task);
                              } else {
                                task.id = widget.task.id;
                                tasks.updateTask(task);
                              }
                              tasks.fetchTask();
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(fontSize: 20),
                            )))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openCustomDialog({BuildContext context, Widget child}) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: child,
            ));
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => null);
}
