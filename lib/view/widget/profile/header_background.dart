import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../clipper/header_clipper_medical.dart';
import '../clipper/profile_clipper.dart';

class ProfileHeaderBackground extends StatelessWidget {
  const ProfileHeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Stack(
        children: [
          Container(
            height: 280,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
              colors: [
                AppColor.secondyColor,
                AppColor.blueColor
                // Color(0xff408bcf),
                // Color(0xff408bcf)
                ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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