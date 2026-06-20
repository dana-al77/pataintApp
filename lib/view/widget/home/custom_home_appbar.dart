import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/routes.dart';
import '../../../controller/notification_controller.dart';
import '../../../core/constant/color.dart';
import '../../../controller/home_controller.dart';
import 'package:get/get.dart';
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeControllerImp controller;
  const CustomHomeAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      elevation: 0,
      toolbarHeight: 120,
      scrolledUnderElevation: 0, // 🔥 أهم سطر
      surfaceTintColor: Colors.transparent, // 🔥 يلغي تغيير اللون
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 10,
          left: 10,
          bottom: 10,
        ),
        child: Row(
          // لجعل المحاذاة تبدأ من اليمين (العربي)
          textDirection: TextDirection.rtl,
          children: [
            // 1. صورة البروفايل
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.teal.withOpacity(0.1),
              backgroundImage: controller.imagePath != null
                  ? FileImage(File(controller.imagePath!))
                  : null,
              child: controller.imagePath == null
                  ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
                child: const Icon(Icons.person, size: 30),
              )
                  : null,
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
          child: GetBuilder<NotificationController>(
            builder: (notifController) => Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notification_important_outlined,
                    color: AppColor.secondyColor,
                    size: 30,
                  ),
                  onPressed: () {
                    notifController.reset();
                    Get.toNamed(AppRoute.notification);
                  },
                ),

                // 🔴 البادج (الرقم)
                if (notifController.unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${notifController.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          )
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1); // زيادة الارتفاع قليلاً لتناسب السطرين
}