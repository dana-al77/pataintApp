import 'package:flutter/material.dart';

import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../appiontement/dilaog.dart';
import 'icon_box.dart';

import 'package:get/get.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerImp());

    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () {
            // 🔥 استدعاء الديالوغ الخاص بكِ عند الضغط على الحاوية
            showCustomConfirmDialog(
              title: "تسجيل الخروج",
              message: "هل تريدين الخروج من حسابكِ؟",
              icon: Icons.logout_rounded,
              iconColor: AppColor.secondyColor, // أو ممكن تحطيها Colors.red
              confirmBtnText: "خروج",
              onConfirm: () => controller.logout(),
            );
          },
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
                // 🔥 ICON BOX (أيقونة الخروج باللون الأحمر)
                IconBox(
                  icon: Icons.logout_rounded,
                  color: Colors.red, // لون أحمر ليعبر عن الخروج
                  backgroundColor: Color(0x1AF44336), // شفافية اللون الأحمر
                ),

                SizedBox(width: 15),

                // 📄 TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تسجيل الخروج",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red, // خلينا النص أحمر ليعطي طابع الخروج
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );

  }
}
