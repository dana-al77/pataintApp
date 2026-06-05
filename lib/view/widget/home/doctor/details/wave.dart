/*

import 'package:flutter/material.dart';
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 50);

    path.quadraticBezierTo(
        size.width * 0.25, size.height - 70, size.width * 0.5, size.height - 30);

    path.quadraticBezierTo(
        size.width * 0.75, size.height + 10, size.width, size.height - 30);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
*/
import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 🔹 البداية من الأعلى يسار
    path.lineTo(0, size.height - 25);

    // 🔹 زاوية سفلية يسار (radius 25)
    path.quadraticBezierTo(
      0,
      size.height,
      25,
      size.height,
    );

    // 🔹 خط سفلي مستقيم
    path.lineTo(size.width - 25, size.height);

    // 🔹 زاوية سفلية يمين (radius 25)
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - 25,
    );

    // 🔹 الرجوع للأعلى
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}