import 'package:flutter/material.dart';

class AppSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const AppSkeleton({
    super.key,
    required this.height,
    required this.width,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}