import 'package:todo_app/models/task.dart';

class TaskCategory {
  int id;
  final String title;
  final List<Task> task;
  TaskCategory({
    this.id,
    this.title,
    this.task,
  });
  factory TaskCategory.fromMap(Map<String, dynamic> map) {
    List<Task> taskList = [];
    map['task'].forEach((map) => taskList.add(Task.fromMap(map)));
    return TaskCategory(
      id: map['id'],
      title: map['title'],
      task: taskList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'task': this.task,
    };
  }
}
