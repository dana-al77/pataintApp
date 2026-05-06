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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
             // ProfileAvatar(controller: controller,),
              ProfileAvatar(
                imageUrl: controller.profileModel?.profileImage,
              ),
              const SizedBox(width: 15),
              ProfileInfo(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}