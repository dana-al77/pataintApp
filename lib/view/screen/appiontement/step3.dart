import 'package:flutter/material.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../widget/appiontement/custom_step3.dart';
import '../../widget/appiontement/custom_text_field.dart';
class Step3Widget extends GetView<FistAppiontController> {
  const Step3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FistAppiontController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "تقريباً انتهينا! بعض التفاصيل الإضافية",
              style: TextStyle(fontSize: 18, color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // كارد التدخين (Smoker Switch)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.smoking_rooms, color: Colors.blueGrey),
                ),
                title: const Text("مدخن؟", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("هل تدخن حالياً؟", style: TextStyle(fontSize: 12)),
                trailing: Switch(
                  value: controller.isSmoker,
                  onChanged: (val) => controller.toggleSmoking(val),
                  activeColor: AppColor.secondyColor,
                ),
              ),
            ),

            // ضغط الدم (حقل قصير)
            CustomStep3(
              label: "ضغط الدم",
              hint: "مثال: 120/80",
              icon: Icons.favorite,
              iconColor: Colors.pinkAccent,
              controller: controller.bloodPressure,
            ),
            CustomStep3(
              label: "الحالة الاجتماعية",
              hint: "single / married",
              icon: Icons.favorite_border,
              iconColor: Colors.redAccent,
              controller: controller.maritalStatus,
            ),

            CustomStep3(
              label: "عدد الأولاد",
              hint: "0",
              icon: Icons.child_care,
              iconColor: Colors.orange,
              controller: controller.numberOfChildren,
            ),
            // العمليات السابقة (حقل طويل)
            CustomStep3(
              label: "العمليات الجراحية السابقة",
              hint: "اذكر أي عمليات أجريتها سابقاً...",
              icon: Icons.description,
              iconColor: Colors.deepPurpleAccent,
              controller: controller.surgeries,
              maxLines: 2, // جعلناه يتسع لأسطر أكثر
            ),

            // التاريخ العائلي (حقل طويل)
            CustomStep3(
              label: "التاريخ الطبي العائلي",
              hint: "أي أمراض وراثية أو تاريخ طبي للعائلة...",
              icon: Icons.groups,
              iconColor: Colors.tealAccent.shade700,
              controller: controller.familyHistory,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}