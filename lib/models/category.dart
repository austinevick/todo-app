import 'package:todo_app/models/task.dart';

class TaskCategory {
  final String id;
  final String title;
  final Task task;
  TaskCategory({
    this.id,
    this.title,
    this.task,
  });
}
