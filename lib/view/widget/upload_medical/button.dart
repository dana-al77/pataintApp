import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class ConfirmUploadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ConfirmUploadButton({
    Key? key,
    required this.onPressed,
    this.text = "تأكيد الرفع", // نص افتراضي باللغة العربية
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ليأخذ الزر العرض الكامل للواجهة بشكل أنيق
      height: 56, // ارتفاع مثالي ومريح للضغط بالإصبع متناسق مع الحقول السابقة
      decoration: BoxDecoration(
        // تطبيق التدرج الماسي الفخم المعتمد (0xFF408BCF) مع الفيروزي الساطع
        gradient: const LinearGradient(
          colors: [
            AppColor.secondyColor ,// لونكِ الأساسي الأنيق
           AppColor.blueColor, // الفيروزي المشرق
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18), // زوايا دائرية ناعمة تتطابق مع حقول الواجهة
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF408BCF).withOpacity(0.35), // ظل ملون يعطي لمسة زجاجية فخمة للزر
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // جعل خلفية الزر شفافة لإظهار التدرج اللوني من الـ Container
          shadowColor: Colors.transparent,     // إلغاء ظل الـ ElevatedButton الافتراضي والاعتماد على ظلك الخاص
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold, // جعل الخط سميكاً وواضحاً كالأزرار السابقة
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}