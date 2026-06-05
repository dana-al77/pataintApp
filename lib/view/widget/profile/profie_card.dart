import 'package:flutter/material.dart';
import 'package:patientapp/view/widget/profile/profile_info.dart';

import '../../../controller/profile/profile_controller.dart';
import '../../../core/constant/color.dart';
import 'avater.dart';

class ProfileCard extends StatelessWidget {
  final ProfileController controller;

  const ProfileCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(
              imageUrl: controller.profileModel?.profileImage,

            ),
            const SizedBox(width: 15),
            ProfileInfo(controller: controller),
          ],
        ),
      ),
    );
  }
}