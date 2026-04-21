import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          // يمكنك إضافة الخط الخاص بتطبيقك هنا ليكون موحداً
        ),
      ),
    );
  }
}