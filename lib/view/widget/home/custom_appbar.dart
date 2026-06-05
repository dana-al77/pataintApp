import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // زر العودة الدائري الأنيق بظله الناعم
            if (showBackButton)
              Positioned(
                top: 50,
                right: 0,
                child: GestureDetector(
                  onTap: onBackPressed ?? () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 20, color: AppColor.black),
                  ),
                ),

              ),

            // عنوان الواجهة مع الأيقونة المرافقة له
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1C24),
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    icon,
                    color: const Color(0xFF408BCF), // لونكِ الماسي المعتمد للأيقونة
                    size: 20,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}