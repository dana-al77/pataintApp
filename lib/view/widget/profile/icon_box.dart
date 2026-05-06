import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double size;
  final double padding;
  final double radius;

  const IconBox({
    super.key,
    required this.icon,
    this.color = Colors.blue,
    this.backgroundColor = const Color(0x1A2196F3), // شفافية افتراضية
    this.size = 22,
    this.padding = 10,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}