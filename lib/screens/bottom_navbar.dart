import 'package:flutter/material.dart';
import 'package:todo_app/screens/category_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screens = [HomeScreen(), CategoryScreen()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() => selectedIndex = value),
        items: [
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Category',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: screens[selectedIndex],
    );
  }
}
