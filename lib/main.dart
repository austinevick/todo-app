import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/note_provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/screens/bottom_navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
          child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            title: 'todo app',
            home: BottomNavBarScreen(),
          ),
        ),
      ],
    );
  }
}
