import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../../../controller/home_controller.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeControllerImp controller;
  const CustomHomeAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0, // 🔥 أهم سطر
      surfaceTintColor: Colors.transparent, // 🔥 يلغي تغيير اللون
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          // لجعل المحاذاة تبدأ من اليمين (العربي)
          textDirection: TextDirection.rtl,
          children: [
            // 1. صورة البروفايل
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.teal.withOpacity(0.1), // لون خفيف خلف الصورة
              backgroundImage: const AssetImage('assets/images/doctor.jpg'), // تأكد من المسار
            ),

            const SizedBox(width: 15), // مسافة بين الصورة والكلام

            // 2. النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "مرحبًا، ${controller.name}",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "نتمنى لك يومًا صحيًا ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.notification_important_outlined, color: AppColor.secondyColor, size: 30),
            onPressed: () => controller.logout(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1); // زيادة الارتفاع قليلاً لتناسب السطرين
}