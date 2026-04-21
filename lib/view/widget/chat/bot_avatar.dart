import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class BotAvatar extends StatelessWidget {
  const BotAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 16,
      backgroundColor: AppColor.secondyColor,
      child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
    );
  }
}