import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/profile/edit_profile_controller.dart';
import '../../../../core/constant/color.dart';


class SaveProfileButton extends StatelessWidget {
  const SaveProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfileController controller = Get.put(EditProfileController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.secondyColor,
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {
            controller.updateProfile();
          },
          child: const Text(
            "حفظ التعديلات",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}