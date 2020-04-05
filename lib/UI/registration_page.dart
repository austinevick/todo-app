import 'package:flutter/material.dart';
import 'package:todo_app/UI/login_page.dart';
import 'package:todo_app/models/users_db.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  UserHelper userHelper = UserHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Register'),),
      body: Center(child: Container(
        child:  Form(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(),
              ),
              FlatButton(onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
              }, child: Text('Already have and account?\n Login')),
              FlatButton(
                  onPressed: () {
                    
                  },
                  child: Text('Create account')),
            ],
          )),
      ),),
    );
  }
}