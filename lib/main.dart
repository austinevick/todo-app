import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Quick Note',
      home: HomeScreen(),
    );
  }
}
