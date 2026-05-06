import 'package:flutter/material.dart';
import '../../../controller/profile/profile_controller.dart';
import 'divider.dart';
import 'info_tilte.dart';

class InfoSection extends StatelessWidget {
  final ProfileController controller;

  const InfoSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [

            InfoRowTile(
              icon: Icons.calendar_today,
              iconColor: Colors.blue,
              iconBackground: Colors.blue.withOpacity(0.1),
              title: "تاريخ الميلاد",
              value: controller.profileModel?.patient?.dateOfBirth ?? "-",
            ),

            const divider(),

            InfoRowTile(
              icon: Icons.location_city,
              iconColor: Colors.orange,
              iconBackground: Colors.orange.withOpacity(0.1),
              title: "المحافظة",
              value: controller.profileModel?.patient?.country ?? "-",
            ),

            const divider(),

            InfoRowTile(
              icon: Icons.public,
              iconColor: Colors.green,
              iconBackground: Colors.green.withOpacity(0.1),
              title: "البلدة",
              value: controller.profileModel?.patient?.city ?? "-",
            ),
            const divider(),
            InfoRowTile(
              icon: Icons.phone_android_outlined,
              iconColor: Colors.purple,
              iconBackground: Colors.purple.withOpacity(0.1),
              title: "رقم الموبايل",
              value: controller.profileModel?.phone ?? "-",
            ),
            const divider(),
          
            InfoRowTile(
              icon: Icons.phone,
              iconColor: Colors.red,
              iconBackground: Color(0x1AFF0000).withOpacity(0.1),
              title: "رقم الطوارئ",
              value:  controller.profileModel?.patient?.emergencyContact ?? "-",
            ),
          ],
        ),
      ),
    );
  }
}