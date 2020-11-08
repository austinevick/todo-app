import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/screens/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  final Task task;

  const AddTaskScreen({Key key, this.task}) : super(key: key);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = new TextEditingController();
  var currentTime = DateTime.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    if (widget.task != null) {
      titleController.text = widget.task.title;
      currentTime = widget.task.date;
    }
    init();
    super.initState();
  }

  init() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('intropage');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return HomeScreen();
    }));
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime = currentTime;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'intropage',
      importance: Importance.Max,
      priority: Priority.High,
      largeIcon: DrawableResourceAndroidBitmap('intropage'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(0, '', 'scheduled body',
        scheduledNotificationDateTime, platformChannelSpecifics);
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
                  children: [
                    FlatButton(
                        onPressed: () async {
                          var date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now());
                          if (date != null) {
                            setState(() => currentTime = date);
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
                SizedBox(
                  height: 50,
                ),
                Container(
                    color: Colors.green,
                    width: 100,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Task task = new Task(
                              title: titleController.text, date: currentTime);
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
          ),
        ),
      ),
    );
  }
}
