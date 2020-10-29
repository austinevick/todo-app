import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/widgets/add_button.dart';

class HomeScreen extends StatelessWidget {
  final CalendarController calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AddButton(
            onTap: () => print('hi'),
          )
        ],
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 400,
              color: Color(0xff301d8f),
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Today'),
                Text('12 Tuedsday'),
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: ListView.builder(itemBuilder: (
                context,
                index,
              ) {
                return Card(
                  child: ListTile(
                    title: Text('Walk with dog'),
                    subtitle: Text('Personal'),
                    trailing: Checkbox(
                      onChanged: (value) {},
                      value: false,
                    ),
                    leading: Container(
                      height: 60,
                      alignment: Alignment.center,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue,
                          )),
                      child: Text(
                        '08:00AM',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
