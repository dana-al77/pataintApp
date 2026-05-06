import 'package:flutter/material.dart';

class MyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);

    var firstControl = Offset(size.width * 0.25, size.height);
    var firstEnd = Offset(size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy,
        firstEnd.dx, firstEnd.dy);

    var secondControl = Offset(size.width * 0.75, size.height * 0.6);
    var secondEnd = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy,
        secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}