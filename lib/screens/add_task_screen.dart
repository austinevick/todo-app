import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = new TextEditingController();
  var currentTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add task',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a title' : null,
                  cursorWidth: 1.5,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  controller: titleController,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Title'),
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () async {
                        var time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() => currentTime = time);
                        }
                      },
                      child: Icon(
                        Icons.timer,
                        size: 30,
                      )),
                  Text(
                    '${currentTime.format(context)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [Icon(Icons.category)],
              ),
              ButtonBar(
                buttonHeight: 45,
                buttonMinWidth: 115,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void openCustomDialog({BuildContext context, Widget child}) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: child,
            ));
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => null);
}
