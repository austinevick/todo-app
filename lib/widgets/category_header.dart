import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String categoryCount;
  const CategoryHeader({
    Key key,
    this.categoryCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                children: [
                  Text('10+'),
                  Text('Categories'),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: -10,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      50,
                    )),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(
                      50,
                    )),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xff301d8f),
            borderRadius: BorderRadius.circular(
              10,
            )),
        width: double.infinity,
        height: 120,
      ),
    );
  }
}
