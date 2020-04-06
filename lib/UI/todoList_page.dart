import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/UI/notekeeper_page.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/models/todoHelper.dart';

import 'add_task_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TaskModel> todoList = List<TaskModel>();
  TextStyle popUpButtonStyle = TextStyle(fontWeight: FontWeight.bold);
  TodoHelper todoHelper = TodoHelper();
  TaskModel taskModel = TaskModel();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    updateTaskList();
    super.initState();
  }

  updateTaskList() {
    Future<List<TaskModel>> list = todoHelper.getTodo();
    list.then((todo) {
      setState(() {
        this.todoList = todo;
      });
    });
  }

  final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');

  completedTask() {
    return todoList.where((task) => task.completed == 1).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Color(0xff0f0b69),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTaskPage(
                            appbarTitle: 'Add Task',
                            callBack: () => updateTaskList(),
                          )));
            },
            child: Icon(
              Icons.add,
              size: 35,
            )),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotekeeperPage()));
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  size: 30,
                ),
                onPressed: () {
                  if (todoList.length > 0) {
                    return showDialog(
                        context: (context),
                        builder: (context) {
                          return AlertDialog(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            title: Center(
                              child: Text(
                                'Delete All Tasks',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            content: Text(
                              'Are you sure you want to delete all tasks',
                              style:
                                  Theme.of(context).dialogTheme.titleTextStyle,
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'.toUpperCase(),
                                      style: Theme.of(context).textTheme.title),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    todoHelper.deleteAllTask();

                                    setState(() {
                                      updateTaskList();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Yes'.toUpperCase(),
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    return Fluttertoast.showToast(msg: 'No task added');
                  }
                }),
           
          ],
          backgroundColor: Color(0xff0f0b69),
          centerTitle: true,
          title: Text('TO-DO-LIST'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Today:  ${dateFormatter.format(dateTime)}'.toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 16),
              child: Text(
                "${completedTask()} of ${todoList.length.toString()} completed"
                    .toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height,
              child: todoList.length > 0
                  ? ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        var _listItems = todoList[index];
                        return Dismissible(
                          key: ValueKey(_listItems.id),
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                  elevation: 8,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddTaskPage(
                                                    appbarTitle: 'Edit Task',
                                                    taskModel: _listItems,
                                                    callBack: () =>
                                                        updateTaskList(),
                                                  )));
                                    },
                                    title: Text(_listItems.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: _listItems.completed == 1
                                                ? Colors.grey
                                                : Colors.purple,
                                            decoration:
                                                _listItems.completed == 1
                                                    ? TextDecoration.lineThrough
                                                    : null)),
                                    subtitle: Text(
                                        _listItems.date +
                                            '  ' +
                                            _listItems.time,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            color: _listItems.completed == 1
                                                ? Colors.grey
                                                : Colors.purple,
                                            decoration:
                                                _listItems.completed == 1
                                                    ? TextDecoration.lineThrough
                                                    : null)),
                                    trailing: Checkbox(
                                        value: _listItems.completed == 1
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() {
                                            _listItems.completed =
                                                value ? 1 : 0;
                                            todoHelper.updateTodo(_listItems);
                                            updateTaskList();
                                          });
                                        }),
                                  ))),
                          background: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                          onDismissed: (action) {
                            todoHelper.deleteTodo(_listItems.id);
                            updateTaskList();
                          },
                        );
                      })
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('asset/todopage.jpeg')),
                            ),
                          ),
                          Text(
                            'ALL TASK DONE',
                            style: TextStyle(
                                fontSize: 25, color: Colors.grey.shade400),
                          )
                        ],
                      ),
                    ),
            ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            notchMargin: 8,
            shape: CircularNotchedRectangle(),
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))))));
  }
}
