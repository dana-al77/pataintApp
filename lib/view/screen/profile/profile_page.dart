import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';

import '../../../controller/profile/profile_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../widget/clipper/profile_clipper.dart';
import '../../widget/profile/emergency_card.dart';
import '../../widget/profile/header_background.dart';
import '../../widget/profile/info_section.dart';
import '../../widget/profile/logout.dart';
import '../../widget/profile/profie_card.dart';
import '../../widget/profile/topBar.dart';
import '../../widget/profile/verified_account.dart';
import '../../widget/skelton/profile_skeleton.dart';
import 'edit_profile_page.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body:GetBuilder<ProfileController>(
        builder: (controller) => HandlingDataModern(
          statusRequest: controller.statusRequest,


          onRetry: () {
            controller.getProfile();
          },

          widget: SingleChildScrollView(
            child: Stack(
              children: [
                const ProfileHeaderBackground(),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      const ProfileTopBar(
                        isEditPage: false,
                      ),

                      const SizedBox(height: 8),

                      ProfileCard(controller: controller),

                      const SizedBox(height: 8),

                      InfoSection(controller: controller),

                      const SizedBox(height: 10),

                      Logout(),

                      const SizedBox(height: 10),

                      const VerifiedSection(),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      // GetBuilder<ProfileController>(
      //   builder: (controller) => handlingDataView(
      //     statusRequest: controller.statusRequest,
      //     widget: SingleChildScrollView(
      //       child: Stack(
      //         children: [
      //           const ProfileHeaderBackground(),
      //
      //           SingleChildScrollView(
      //             child: Column(
      //               children: [
      //                 const SizedBox(height:40),
      //
      //                // const ProfileTopBar(),
      //                 const ProfileTopBar(
      //                   isEditPage: false,
      //                 ),
      //                 const SizedBox(height: 8),
      //
      //                 ProfileCard(controller: controller),
      //
      //                 const SizedBox(height: 8),
      //
      //                 InfoSection(controller: controller),
      //
      //                 const SizedBox(height: 10),
      //
      //               //  EmergencyCard(controller: controller),
      //
      //                // const SizedBox(height: 10),
      //                 Logout(),
      //                 const SizedBox(height: 10),
      //                 const VerifiedSection(),
      //
      //                 const SizedBox(height: 100),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
