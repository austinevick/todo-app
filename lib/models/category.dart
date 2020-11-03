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

List<TaskCategory> categories = [
  TaskCategory(id: 1, title: 'Work'),
  TaskCategory(id: 1, title: 'Event'),
  TaskCategory(id: 1, title: 'Personal'),
  TaskCategory(id: 1, title: 'Shopping'),
];
