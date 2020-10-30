import 'category.dart';

class Task {
  int id;
  String title;
  List<TaskCategory> categories;
  String date;
  int complete;
  Task({
    this.id,
    this.title,
    this.date,
    this.categories,
    this.complete,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        date: map['date'],
        categories: map['categories'],
        complete: map['completed']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'categories': this.categories,
      'date': this.date,
      'completed': this.complete
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, categories: $categories, date: $date, complete: $complete)';
  }
}
