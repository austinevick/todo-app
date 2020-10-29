import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onTap;

  const AddButton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 20,
            alignment: Alignment.center,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue,
                )),
            child: Icon(Icons.add)),
      ),
    );
  }
}
