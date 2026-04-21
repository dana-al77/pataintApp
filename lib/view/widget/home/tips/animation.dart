import 'package:flutter/cupertino.dart';

class AnimatedCard extends StatelessWidget {
  final Widget child;

  const AnimatedCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
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