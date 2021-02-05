import 'package:flutter/material.dart';
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
  var currentTime;

  @override
  void initState() {
    if (widget.task != null) {
      this.titleController.text = widget.task.title;
      currentTime = widget.task.date;
    }
    super.initState();
  }

  submitTask(TaskProvider tasks) {
    Navigator.of(context).pop();
    Task task = new Task(title: titleController.text, date: currentTime);
    if (widget.task == null) {
      task.complete = 0;
      tasks.addTask(task);
      print(task);
    } else {
      task.id = widget.task.id;
      tasks.updateTask(task);
    }
    tasks.fetchTask();
  }

  setTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => currentTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, tasks, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add task',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                onChanged: (val) => setState(() {}),
                cursorWidth: 1,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontSize: 18,
                ),
                controller: titleController,
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Title'),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () => setTime(),
                title: Text('$currentTime', style: TextStyle(fontSize: 20)),
                leading: Icon(Icons.alarm),
              ),
              Spacer(),
              titleController.text.isEmpty
                  ? Container()
                  : Container(
                      height: 55,
                      color: Colors.green,
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () => submitTask(tasks),
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(fontSize: 25),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
