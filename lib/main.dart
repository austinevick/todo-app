import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/UI/intro_page.dart';
import 'package:todo_app/UI/notekeeper_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(defaultBrightness: Brightness.light,
        data: (brightness) =>
            new ThemeData(primarySwatch: Colors.indigo, brightness: brightness),
        themedWidgetBuilder: (context, theme) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Quick Note',
              home: IntroPage(),
            ));
  }
}
