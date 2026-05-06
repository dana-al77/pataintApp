
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../../controller/profile/profile_controller.dart';
import '../../screen/profile/edit_profile_page.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return GestureDetector(
      onTap: () async {
        var result = await Get.to(
              () => const EditProfilePage(),
          arguments: controller.profileModel,
        );

        if (result == true) {
          controller.getProfile(); // refresh بعد التعديل
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColor.secondyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 16, color: AppColor.secondyColor),
            SizedBox(width: 5),
            Text("تعديل الحساب"),
          ],
        ),
      ),
    );
  }
}