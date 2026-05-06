import 'package:flutter/material.dart';
import 'icon_box.dart';

class VerifiedSection extends StatelessWidget {
  const VerifiedSection({super.key});

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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const Row(
          children: [

            // 🔥 ICON BOX (نفس القديم لكن reusable)
            IconBox(
              icon: Icons.verified_user_outlined,
              color: Colors.green,
              backgroundColor: Color(0x1A4CAF50), // green opacity
            ),

            SizedBox(width: 15),

            // 📄 TEXT (نفس القديم 100%)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "توثيق الحساب",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "حسابك آمن ومُوثّق بالكامل ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // ✔️ CHECK ICON (نفس القديم)
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}