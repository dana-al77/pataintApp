import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/color.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String text ;
  const CustomTextTitleAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return   Text(text,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
      fontSize: 18, // ← غيّر الرقم لحجم الخط المطلوب
      color: Colors.black87, // ← غيّر اللون حسب الحاجة (مثلاً AppColor.primaryColor)
      fontWeight: FontWeight.w700, // (اختياري) تعطي ثقل للخط

    )

    );
  }
}
