import 'package:flutter/material.dart';
import 'package:get/get.dart';

// اسم جديد كلياً لمنع التضارب مع كلاس البحث القديم
class PioneersMedicalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;          // نص العنوان
  final IconData? icon;        // الأيقونة بجانب العنوان (اختيارية)
  final bool showBackButton;   // خيار إظهار أو إخفاء زر العودة
  final VoidCallback? onBackPressed;

  const PioneersMedicalAppBar({
    Key? key,
    required this.title,
    this.icon,
    this.showBackButton = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 10.0,left: 16,bottom: 2),
        child: SizedBox(
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // زر العودة الدائري الأنيق بظله الناعم
              if (showBackButton)
          Positioned(
          right: 16, // مسافة أمان جانبية للـ RTL لتبدو احترافية
          child: Center( // هذا الـ Center هو السر الهندسي ليظل الـ Container دائرياً تماماً
            child: GestureDetector(
              onTap: () => Get.back(), // العودة خطوة للخلف باستخدام حزمة GetX
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white, // خلفية بيضاء نقية
                  shape: BoxShape.circle, // جعل التصميم دائرياً بالكامل
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08), // ظل ناعم وحديث بستايل Dribbble
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded, // أيقونة السهم للواجهات العربية (RTL)
                  size: 18,
                  color: Colors.black87, // لون داكن ومريح للعين للأيقونة
                ),
              ),
            ),
          ),
                ),

              // عنوان الواجهة مع الأيقونة المرافقة له
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      icon,
                      color: const Color(0xFF408BCF), // لونكِ الماسي المعتمد للأيقونة
                      size: 20,
                    ),
                  ],
                  SizedBox(width: 5,),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1C24),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}