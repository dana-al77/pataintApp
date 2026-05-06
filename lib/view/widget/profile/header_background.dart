import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../clipper/profile_clipper.dart';

class ProfileHeaderBackground extends StatelessWidget {
  const ProfileHeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyWaveClipper(),
      child: Stack(
        children: [
          Container(
            height: 240,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.secondyColor.withOpacity(0.7),
                  AppColor.secondyColor.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          //   child: Container(
          //     height: 240,
          //   //  color: Colors.white.withOpacity(0.4),
          //   ),
          // ),
        ],
      ),
    );
  }
}