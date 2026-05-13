import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const InfoText({
    required this.text,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.grey.shade700,
        fontSize: fontSize ?? 15,
      ),
    );
  }
}