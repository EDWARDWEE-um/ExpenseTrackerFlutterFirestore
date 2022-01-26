import 'package:flutter/material.dart';

class BottomToTopSlideTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const BottomToTopSlideTransition(
      {Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.ease),
        ),
      ),
      child: child,
    );
  }
}
