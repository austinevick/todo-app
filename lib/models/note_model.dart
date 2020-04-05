class NoteModel{
  int id;
  String title;
  bool isSelected = false;
  NoteModel({this.id,this.title,this.isSelected = false});

  Map<String,dynamic> toMap(){
    return {
'id': id,
'title': title
    };
  }
  NoteModel.fromMap(Map<String, dynamic> maps){
id = maps['id'];
title = maps['title'];
  }
}