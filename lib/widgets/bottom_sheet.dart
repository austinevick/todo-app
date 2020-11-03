import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';

import 'custom_dialog.dart';

class CustomBottomSheet extends StatelessWidget {
  final Task task;
  const CustomBottomSheet({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, tasks, child) => Container(
        height: MediaQuery.of(context).size.height / 3.8,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ListTile(
              subtitle: Text(''),
              title: Text(
                task.title,
                style: TextStyle(
                    color: task.complete == 0 ? Colors.white : Colors.grey,
                    decoration: task.complete == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              leading: Container(
                height: 60,
                alignment: Alignment.center,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                    )),
                child: Text(
                  task.date,
                  style: TextStyle(
                    fontSize: 11,
                    color: task.complete == 0 ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
            Divider(
              height: 0,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  tasks.completedTask(task);
                },
                child: Text(
                  task.complete == 0
                      ? 'Mark as complete'
                      : 'Mark as incomplete',
                  style: TextStyle(fontSize: 18),
                )),
            Divider(
              height: 0,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showGeneralDialog(
                      transitionDuration: Duration(milliseconds: 400),
                      barrierDismissible: true,
                      barrierLabel: '',
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder:
                          (ctx, animation, secondaryAnimation, widget) =>
                              CustomDialog(
                                primaryAnimation: animation,
                                secondaryAnimation: secondaryAnimation,
                                child: AddTaskScreen(
                                  task: task,
                                ),
                              ),
                      context: context,
                      pageBuilder: (context, a1, a2) => null);
                },
                child: Text(
                  'Edit Task',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
