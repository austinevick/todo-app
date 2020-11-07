import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to delete this task?'),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('DELETE')),
        FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('CANCEL')),
      ],
    );
  }
}
