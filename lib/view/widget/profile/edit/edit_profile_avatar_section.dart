import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/profile/edit_profile_controller.dart';
import '../avater.dart';


class EditProfileAvatarSection extends StatelessWidget {
  const EditProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) {
        return ProfileAvatar(
          imageUrl: controller.profileModel.profileImage,
          imageFile: controller.imageFile,
          isEditing: true,
          onTap: controller.pickImage,
        );
      },
    );
  }
}