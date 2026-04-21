import 'package:flutter/cupertino.dart';

class BottomBarClipper extends CustomClipper<Path> {
  final int index;

  BottomBarClipper(this.index);

  @override
  Path getClip(Size size) {
    final path = Path();

    int itemCount = 4;
    int fixedIndex = itemCount - 1 - index;

    double itemWidth = size.width / itemCount;
    double centerX = (fixedIndex * itemWidth) + itemWidth / 2;

    const double fabSize = 50;
    const double notchMargin = 6;

    double notchRadius = (fabSize / 2) + notchMargin;

    path.lineTo(0, 0);

    // قبل الفراغ
    path.lineTo(centerX - notchRadius, 0);

    // 🔥 الفراغ (متناسق 100%)
    path.quadraticBezierTo(
      centerX,
      notchRadius * 2.1, // عمق مضبوط
      centerX + notchRadius,
      0,
    );

    // بعد الفراغ
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}