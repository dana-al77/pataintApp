import 'package:flutter/material.dart';
import '../../../controller/chat/chat_controller.dart';
import '../../../core/constant/color.dart';
import '../../../data/model/chat/opption.dart';

class QuickOptionsWidget extends StatelessWidget {
  final List<ChatOption> options;
  final ChatController controller;

  const QuickOptionsWidget({
    super.key,
    required this.options,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: options.map((option) {
        return InkWell(
          onTap: () => controller.handleOptionTap(option),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.secondyColor),
            ),
            child: Text(
              option.title,
              style: const TextStyle(
                color: AppColor.secondyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}