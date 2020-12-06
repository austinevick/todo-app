class Note {
  int id;
  final String title;
  final String content;
  final String image;
  final String date;

  Note({this.content, this.image, this.date, this.id, this.title});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      content: map['content'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'image': this.image ?? '',
      'content': this.content,
      'date': this.date,
    };
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, date: $date)';
  }
}
