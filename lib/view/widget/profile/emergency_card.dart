import 'package:flutter/material.dart';
import '../../../controller/profile/profile_controller.dart';
import 'icon_box.dart';

class EmergencyCard extends StatelessWidget {
  final ProfileController controller;

  const EmergencyCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [

            // 🔥 ICON BOX (بدل القديم Container)
            const IconBox(
              icon: Icons.phone,
              color: Colors.red,
              backgroundColor: Color(0x1AFF0000), // red with opacity
            ),

            const SizedBox(width: 15),

            // 📄 TEXT (نفس القديم 100%)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Emergency Contact",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.profileModel?.patient?.emergencyContact ?? "-",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}