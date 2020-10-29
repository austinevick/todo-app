import 'package:todo_app/models/task.dart';

class TaskCategory {
  final String id;
  final String title;
  final List<Task> task;
  TaskCategory({
    this.id,
    this.title,
    this.task,
  });
}
