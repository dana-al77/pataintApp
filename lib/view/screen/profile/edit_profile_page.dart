import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile/edit_profile_controller.dart';
import '../../../core/constant/color.dart';
import '../../widget/profile/avater.dart';
import '../../widget/profile/divider.dart';
import '../../widget/profile/edit/edit_profile_avatar_section.dart';
import '../../widget/profile/edit/edit_profile_section.dart';
import '../../widget/profile/edit/save_profile_button.dart';
import '../../widget/profile/header_background.dart';
import '../../widget/profile/info_tilte.dart';
import '../../widget/profile/topBar.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          const ProfileHeaderBackground(),

          SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 40),

                const ProfileTopBar(
                  isEditPage: true,
                ),
                const SizedBox(height: 40),
                const EditProfileAvatarSection(),
                const SizedBox(height: 30),

                // ===================== CARD 1 =====================
                const EditProfileSection(),
                const SizedBox(height: 20),

                // ===================== SAVE BUTTON =====================
                const SaveProfileButton(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }



}