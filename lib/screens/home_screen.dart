import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/widgets/add_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalendarController calendarController = CalendarController();
  @override
  void initState() {
    Provider.of<TaskProvider>(
      context,
      listen: false,
    ).fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          AddButton(
            icon: Icons.add,
            onTap: () => openCustomDialog(
              context: context,
              child: AddTaskScreen(
                key: ValueKey('add'),
              ),
            ),
          )
        ],
        title: Text('Schedule'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, tasksProvider, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Today'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(DateFormat.yMd().format(DateTime.now())),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: ListView.builder(
                    itemCount: tasksProvider.taskList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final task = tasksProvider.taskList[index];
                      return Card(
                        child: ListTile(
                          onTap: () => openCustomDialog(
                              context: context,
                              child: AddTaskScreen(
                                key: ValueKey('update'),
                                task: task,
                              )),
                          title: Text(task.title),
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
                              task.date,
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
      ),
    );
  }
}
