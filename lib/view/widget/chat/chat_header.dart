import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/constant/color.dart';
import 'package:get/get.dart';

import '../../../core/constant/routes.dart';
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: const BoxDecoration(
        color: AppColor.secondyColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.smart_toy, color: AppColor.secondyColor),
          ),
          const SizedBox(width: 10),
          const Column(
// 👈 يوزع المساحة المتاحة في المنتصف بالتساوي بين العناصر وفوقها وتحتها
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible( // 👈 يحمي النص من تجاوز الحدود
                  child: Text("مرحباً 👋", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                Flexible( // 👈 يحمي النص من تجاوز الحدود
                  child: Text("مساعد الحجز الذكي", style: TextStyle(color: Colors.white70, fontSize: 15)),
                ),
              ],
          ),
          const Spacer(),
          IconButton(
            onPressed: (){
              Get.offAllNamed(AppRoute.HomeScreen);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: AppColor.white,
            ),
          ),
        ],
      )
    );
  }
}