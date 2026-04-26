import 'package:flutter/material.dart';

class GlassClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 120);

    path.quadraticBezierTo(
      size.width / 2,
      300, // 👈 هون الحل (خليها أكبر من 120)
      size.width,
      120,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}