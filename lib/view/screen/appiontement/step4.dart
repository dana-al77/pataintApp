
import 'package:flutter/material.dart';
import 'package:patientapp/view/widget/appiontement/custom_step3.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import 'package:get/get.dart';

import '../../widget/appiontement/custom_text_field.dart';
import '../../widget/appiontement/review_card.dart';
// class Step4Widget extends GetView<FistAppiontController> {
//   const Step4Widget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ListView(
//         children: [
//           const Text("مراجعة البيانات", style: TextStyle(fontSize: 20)),
//
//           ...controller.reviewData(),
//
//           const SizedBox(height: 20),
//
//           CustomTextField(label: "ملاحظات", controller: controller.notes),
//         ],
//       ),
//     );
//   }
// }
class Step4Widget extends GetView<FistAppiontController> {
  const Step4Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FistAppiontController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero, // لإلغاء المسافة العلوية كما طلبت سابقاً
          children: [
            const SizedBox(height: 20),
            // const Text(
            //   "ممتاز! راجع معلوماتك قبل التأكيد",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 14, color: Color(0xFF00B4D8), fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 20),

            // الكارد الأول: المعلومات الأساسية (التي كانت في الخطوة 0)
            // الكارد الأول: المعلومات الأساسية (ستبقى بالشكل الذي تريده)
            ReviewCard(
              title: "المعلومات الأساسية",
              onEdit: () => controller.goToStep(0),
              isGrid: true, // تفعيل عرض النص بجانب العنوان
              items: [
                ReviewItem(label: "الطول", values: ["${controller.height.text} سم"]),
                ReviewItem(label: "الوزن", values: ["${controller.weight.text} كغ"]),
                ReviewItem(label: "فصيلة الدم", values: [controller.bloodType.text]),
              ],
            ),

            // الكارد الثاني: الحالة الصحية (التي كانت في الخطوة 1)
            // داخل الـ ListView في Step4Widget:

            ReviewCard(
              title: "الحالة الصحية",
              onEdit: () => controller.goToStep(1),
              items: [
                ReviewItem(
                  label: "الأمراض المزمنة:",
                  // نحول النص المخزن في الكنترولر إلى List ليعرض كل واحد بـ Chip منفصل
                  values: controller.chronicDiseases.text.isEmpty ? ["لا يوجد"] : controller.chronicDiseases.text.split(','),
                  customColor: Colors.redAccent, // لون أحمر كما في الصورة للامراض المزمنة
                ),
                ReviewItem(
                  label: "الحساسية:",
                  values: controller.allergies.text.isEmpty ? ["لا يوجد"] : controller.allergies.text.split(','),
                  customColor: Colors.orange, // لون برتقالي للحساسية
                ),
                ReviewItem(
                  label: "الأدوية:",
                  values: controller.medications.text.isEmpty ? ["لا يوجد"] : controller.medications.text.split(','),
                  customColor: Colors.cyan, // لون سماوي للأدوية
                ),
              ],
            ),

            // الكارد الثالث: نمط الحياة (التي كانت في الخطوة 2)
            ReviewCard(
              title: "نمط الحياة والتاريخ الطبي",
              onEdit: () => controller.goToStep(2),
              isGrid: true,
              items: [
                ReviewItem(label: "مدخن؟", values:[ controller.isSmoker ? "نعم" : "لا"]),
                ReviewItem(label: "ضغط الدم", values: [controller.bloodPressure.text]),
              ],
            ),
            CustomStep3(
              label: "مبلغ العربون",
              hint: "أدخل مبلغ الدفع",
              icon: Icons.payments_outlined,
              iconColor: Colors.green,
              controller: controller.amount,
            ),
           // const SizedBox(height: 10),
            // حقل الملاحظات الإضافية
            CustomStep3(
              label: "ملاحظات إضافية",
              hint: "هل هناك أي شيء آخر تريد إخبار الطبيب به؟",
              icon: Icons.note_alt_outlined,
              iconColor: Colors.blueGrey,
              controller: controller.notes,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}