
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile/profile_controller.dart';
import '../../screen/profile/edit_profile_page.dart';

class ProfileTopBar extends StatelessWidget {
  final bool isEditPage; // 🔥 هل الصفحة تعديل؟

  const ProfileTopBar({
    super.key,
    this.isEditPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          /// 📝 النص حسب الصفحة
          Text(
            isEditPage ? "تعديل الحساب" : "الحساب الشخصي",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          /// 🎯 الأيقونة حسب الصفحة
          IconButton(
            icon: Icon(
              isEditPage ? Icons.arrow_forward_ios : Icons.edit,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              if (isEditPage) {
                /// 🔙 رجوع
                Get.back();
              } else {
                Get.to(
                      () => const EditProfilePage(),
                  arguments: controller.profileModel,
                );

              }
            },
          ),
        ],
      ),
    );
  }
}