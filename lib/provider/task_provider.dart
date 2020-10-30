import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/task_database.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final TaskDatabaseHelper databaseHelper = new TaskDatabaseHelper();
  List<Task> taskList = [];

  fetchTask() {
    Future<List<Task>> tasks = databaseHelper.getTasks();
    tasks.then((task) {
      taskList = task;
      notifyListeners();
    });
  }

  void addTask(Task task) {
    databaseHelper.saveTask(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    databaseHelper.updateTask(task);
  }

  void deleteTask(int id) {
    databaseHelper.deleteTask(id);
  }

  void completedTask(Task task, bool value) {
    task.complete = value ? 1 : 0;
    notifyListeners();
  }
}
