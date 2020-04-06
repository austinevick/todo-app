import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/models/todoHelper.dart';

class AddTaskPage extends StatefulWidget {
  final String appbarTitle;
  final TaskModel taskModel;
  final Function callBack;
  AddTaskPage({
    this.taskModel,
    this.callBack,
    this.appbarTitle,
  });

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TodoHelper todoHelper = TodoHelper();
  static TimeOfDay _selectedTime = TimeOfDay.now();

  static DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    if (widget.taskModel != null) {
      titleController.text = widget.taskModel.title;
      dateController.text = widget.taskModel.date;
      timeController.text = widget.taskModel.time;
    }
    dateController.text = DateFormat.yMMMd().format(_selectedDate);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    Timer(Duration(hours: _selectedTime.hour, minutes: _selectedTime.minute),
        () {
return showScheduledNotification();

    });

    super.initState();
  }

  showScheduledNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2012),
            lastDate: DateTime(2030))
        .then((date) {
      if (date == null) {
        return;
      }
      date = date;
      setState(() {
        _selectedDate = date;
      });
    });
    setState(() {
      dateController.text = DateFormat.yMMMd().format(_selectedDate);
    });
  }

  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time;
      });
      timeController.text = time.format(context);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0f0b69),
          centerTitle: true,
          title: Text(widget.appbarTitle),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.done),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    print(
                        '${titleController.text + ' ' + timeController.text + ' ' + dateController.text}');
                    TaskModel taskModel = TaskModel(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);

                    if (widget.taskModel == null) {
                      taskModel.completed = 0;
                      todoHelper.insertTodo(taskModel);
                    } else {
                      taskModel.completed = widget.taskModel.completed;
                      taskModel.id = widget.taskModel.id;
                      todoHelper.updateTodo(taskModel);
                    }
                    widget.callBack();
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 400,
            decoration: BoxDecoration(
                color: Color(0xff0f0b69),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            validator: (value) =>
                                value.isEmpty ? 'Please enter title' : null,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter title',
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500)),
                            controller: titleController,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextFormField(
                            controller: dateController,
                            readOnly: true,
                            textInputAction: TextInputAction.done,
                            autofocus: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            onTap: () {
                              _pickUserDueDate();
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.5),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextFormField(
                            controller: timeController,
                            readOnly: true,
                            textInputAction: TextInputAction.done,
                            autofocus: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            onTap: () {
                              _pickUserDueTime();
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              hintText: _selectedTime == null
                                  ? _selectedTime.format(context)
                                  : 'Set time',
                              border: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.5),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
