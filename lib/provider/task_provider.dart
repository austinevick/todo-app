import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/task_database.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final TaskDatabaseHelper databaseHelper = new TaskDatabaseHelper();
  List<Task> _taskList = [];
  List<Task> get taskList => _taskList;

  void addTask(Task task) {
    databaseHelper.saveTask(task);
    notifyListeners();
  }

  void getTask() {
    databaseHelper.getTasks();
    notifyListeners();
  }
}
