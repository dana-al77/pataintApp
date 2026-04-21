import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
    AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..repeat();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose(); // 🔥 هذا السطر هو الحل
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColor.secondyColor,
          child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
        ),
        SizedBox(width: 8),
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            int count = (controller.value * 3).floor();
            String dots = "." * (count + 1);
            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(dots,style: TextStyle(fontSize: 19,color: AppColor.secondyColor),),
            );
          },
        ),
      ],
    );
  }
}
