class TaskModel {
  int id;
  String title;
  String date;
  String time;
  int completed;
  bool selected = false;

  TaskModel(
      {this.id, this.date, this.time, this.title, this.completed,this.selected});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'date': date,
      'time': time
    };
  }

  TaskModel.fromMap(Map<String, dynamic> maps) {
    id = maps['id'];
    title = maps['title'];
    completed = maps['completed'];
    date = maps['date'];
    time = maps['time'];
  }
}
