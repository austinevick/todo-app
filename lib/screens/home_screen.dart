import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final CalendarController calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State management with provider'),
      ),
      body: Consumer<UiSettings>(
        builder: (context, settings, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Bold font', style: settings.textStyle),
              Switch(
                  value: settings.boldFont,
                  onChanged: (value) {
                    settings.setBoldfont(value);
                  }),
              Text('Iorem ipsum', style: settings.textStyle),
              SizedBox(
                height: 20,
              ),
              Slider(
                  min: 12,
                  max: 30,
                  divisions: 10,
                  label: settings.fontSize.toStringAsFixed(2),
                  value: settings.fontSize,
                  onChanged: (v) {
                    settings.setFontSize(v);
                  }),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    color: settings.color,
                    borderRadius: BorderRadius.circular(settings.boxRadius)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      color: Colors.pink,
                      onPressed: () {
                        settings.setColor(Colors.pink);
                      },
                      child: Text(
                        'Pink',
                        style: settings.textStyle,
                      )),
                  FlatButton(
                      color: Colors.yellow,
                      onPressed: () {
                        settings.setColor(Colors.yellow);
                      },
                      child: Text(
                        'Yellow',
                        style: settings.textStyle,
                      )),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        settings.setColor(Colors.blue);
                      },
                      child: Text(
                        'Blue',
                        style: settings.textStyle,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    color: settings.color,
                    borderRadius: BorderRadius.circular(
                      settings.boxRadius,
                    )),
              ),
              Slider(
                  min: 5,
                  max: 50,
                  divisions: 10,
                  label: settings.boxRadius.toStringAsFixed(0),
                  value: settings.boxRadius,
                  onChanged: (v) {
                    settings.setBoxRadius(v);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
