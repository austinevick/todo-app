import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/widgets/add_button.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('All Note'),
        actions: [
          AddButton(
            icon: Icons.add,
            onTap: () {},
          )
        ],
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 100,
              color: Color(0xff301d8f),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'hello my name is mike I am from Akwa ibom',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
        itemCount: 20,
        staggeredTileBuilder: (index) => StaggeredTile.count(
            (index % 5 == 0) ? 3 : 1, (index % 5 == 0) ? 1 : 1),
      ),
    );
  }
}
