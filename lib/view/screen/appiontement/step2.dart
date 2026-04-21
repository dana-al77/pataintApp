
import 'package:flutter/material.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../widget/appiontement/chips_field.dart';

class Step2Widget extends GetView<FistAppiontController> {
  const Step2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FistAppiontController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
           // const SizedBox(height: 10),
            const Text(
              "حالتك الصحية",

              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold
              ),
            ),
           const SizedBox(height: 10),

            ChipsField(
              title: "الأمراض المزمنة",
              icon: Icons.timeline, // أيقونة النبض
              iconColor: Colors.pinkAccent,
              textController: controller.chronicDiseases,
              options: controller.chronicOptions,
            ),

            ChipsField(
              title: "الحساسية",
              icon: Icons.error_outline, // أيقونة التنبيه
              iconColor: Colors.orange,
              textController: controller.allergies,
              options: controller.allergyOptions,
            ),

            ChipsField(
              title: "الأدوية الحالية",
              icon: Icons.medication_outlined, // أيقونة الدواء
              iconColor: Colors.cyan,
              textController: controller.medications,
              options: controller.medicationOptions,
            ),
          ],
        ),
      ),
    );
  }
}
