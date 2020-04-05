import 'package:flutter/material.dart';
import 'package:todo_app/UI/registration_page.dart';
import 'package:todo_app/models/users_db.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserHelper userHelper = UserHelper();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          child: Form(
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
              FlatButton(onPressed: () {}, child: Text('Login')),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                  },
                  child: Text('Create account')),
            ],
          )),
        ),
      ),
    );
  }
}
