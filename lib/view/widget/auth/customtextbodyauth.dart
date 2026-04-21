import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomTextBodyAuth extends StatelessWidget {
  final String text;
  const CustomTextBodyAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Text(text,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 14, // ← غيّر الرقم لحجم الخط المطلوب
        color: AppColor.black, // ← غيّر اللون حسب الحاجة (مثلاً AppColor.primaryColor)
        fontWeight: FontWeight.bold, // (اختياري) تعطي ثقل للخط

      ))
    );
  }
}
