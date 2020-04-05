import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/UI/home_page.dart';
import 'package:todo_app/UI/notekeeper_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => NotekeeperPage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3f51b5),
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, 0))],
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'asset/app_icon.jpg',
                  ))),
        ),
      ),
    );
  }
}
