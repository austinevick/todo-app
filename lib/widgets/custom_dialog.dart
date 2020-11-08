import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;
  final Animation<double> primaryAnimation;
  final Animation<double> secondaryAnimation;

  const CustomDialog({
    Key key,
    @required this.primaryAnimation,
    @required this.secondaryAnimation,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: primaryAnimation.value,
        child: Opacity(
          opacity: primaryAnimation.value,
          child: child,
        ));
  }
}
