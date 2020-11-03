import 'package:todo_app/models/task.dart';

class TaskCategory {
  int id;
  final String title;
  // final Task task;
  TaskCategory({
    this.id,
    this.title,
    // this.task,
  });
  factory TaskCategory.fromMap(Map<String, dynamic> map) {
    return TaskCategory(
      id: map['id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'title': this.title};
  }
}
