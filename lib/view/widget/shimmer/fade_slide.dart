import 'package:flutter/cupertino.dart';

class FadeSlideAnimation extends StatelessWidget {
  final Widget child;
  final int index;

  const FadeSlideAnimation({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)), // 👈 stagger effect
      tween: Tween(begin: 30.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: 1 - (value / 30),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}