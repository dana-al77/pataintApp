import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomServiceItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final void Function()? onTap;

  const CustomServiceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // 1. الكرت المربع الخارجي (بزوايا منحنية ولون خفيف)
          Container(
            width: 70.w, // استخدام ScreenUtil للتجاوب
            height: 70.h,
            decoration: BoxDecoration(
              // نستخدم لون الخلفية مع شفافية عالية جداً ليعطي المظهر الباهت
              color: backgroundColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Center(
              // 2. الدائرة البيضاء الداخلية (كما في الصورة)
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Colors.white, // الدائرة دائماً بيضاء
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor, // الأيقونة تأخذ اللون الأساسي
                  size: 26.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // 3. النص أسفل الكرت
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}