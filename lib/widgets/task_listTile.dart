import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/add_task_screen.dart';

import 'bottom_sheet.dart';
import 'custom_dialog.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({Key key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showGeneralDialog(
          transitionDuration: Duration(milliseconds: 400),
          barrierDismissible: true,
          barrierLabel: '',
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (ctx, animation, secondaryAnimation, widget) =>
              CustomDialog(
                primaryAnimation: animation,
                secondaryAnimation: secondaryAnimation,
                child: AddTaskScreen(
                  task: task,
                ),
              ),
          context: context,
          pageBuilder: (context, a1, a2) => null),
      title: Text(
        task.title,
        style: TextStyle(
            color: task.complete == 0 ? Colors.white : Colors.grey,
            decoration: task.complete == 0
                ? TextDecoration.none
                : TextDecoration.lineThrough),
      ),
      subtitle: Text(''),
      trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => showModalBottomSheet(
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (ctx) => CustomBottomSheet(
                  task: task,
                ),
              )),
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
          task.date.toString(),
          style: TextStyle(
            fontSize: 11,
            color: task.complete == 0 ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
