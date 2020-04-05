
class UserModel{
  int id;
  String username;
  String password;
  UserModel({this.id,this.password,this.username});
  
  Map<String,dynamic> toMap(){
    return{
'id': id,
'username':username,
'password':password
    };
  }
  UserModel.fromMap(Map<String, dynamic> maps){
 id = maps['id'];
 username = maps['username'];
 password = maps['password'];
  }
}