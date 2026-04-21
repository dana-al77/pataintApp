import 'package:flutter/material.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../widget/appiontement/custom_dropDown.dart';
import '../../widget/appiontement/custom_text_field.dart';

class Step1Widget extends GetView<FistAppiontController> {
  const Step1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("المعلومات الأساسية",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

         // const SizedBox(height: 15),

          CustomTextField(
            label: "الطول (cm)",
            controller: controller.height,
            hint: "أدخل طولك هنا",
          ),

          CustomTextField(
            label: "الوزن (kg)",
            controller: controller.weight,
            hint: "أدخل وزنك هنا",
          ),

          const SizedBox(height: 10),

          // اختيار زمرة الدم
          _buildBloodTypeSelector(),

          // مسافة إضافية في الأسفل لضمان عدم تداخل المحتوى مع أزرار التنقل
         // const SizedBox(height: 30),
        ],
      ),
    );
  }

// ويدجت اختيار زمرة الدم بشكل شبكة
  Widget _buildBloodTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "زمرة الدم",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.hadidi,
              fontSize: 14, // تأكد من حجم الخط ليناسب التصميم
            ),
          ),
          // تقليل المسافة هنا عبر تحديد ارتفاع صغير جداً أو استخدام SizedBox
          const SizedBox(height: 8),

          GetBuilder<FistAppiontController>(
            builder: (c) {
              return GridView.builder(
                shrinkWrap: true,
                // إزالة أي Padding افتراضي للـ GridView
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10, // تقليل المسافة الرأسية بين العناصر
                  crossAxisSpacing: 10, // تقليل المسافة الأفقية بين العناصر
                  childAspectRatio: 1.5, // تعديل النسبة لتصبح المربعات أكثر تناسقاً
                ),
                itemCount: controller.bloodTypes.length,
                itemBuilder: (context, index) {
                  String type = controller.bloodTypes[index];
                  bool isSelected = controller.bloodType.text == type;

                  return GestureDetector(
                    onTap: () => controller.setBloodType(type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      /*decoration: BoxDecoration(
                        // استخدام التدرج اللوني الذي عرفناه سابقاً عند الاختيار
                        gradient: isSelected
                            ? const LinearGradient(colors: AppColor.serviceGradient)
                            : null,
                        color: isSelected ? null : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        // إضافة ظل خفيف عند الاختيار ليعطي تأثير التوهج
                        boxShadow: isSelected
                            ? [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 3))]
                            : [],
                      ),*/
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.secondyColor // 👈 اللون اللي بدك ياه عند الاختيار
                            : Colors.grey.shade100,

                        borderRadius: BorderRadius.circular(15),

                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: AppColor.secondyColor.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      )
    );
  }
}