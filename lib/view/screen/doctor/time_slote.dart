import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart'; // تأكد من استيراد ملف الألوان الخاص بك

import '../../../controller/appiontement/appiontement_controller.dart';
import '../../../core/class/statusrequest.dart';

class ScheduleTimeWidget extends StatelessWidget {
  const ScheduleTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        if (controller.statusRequest == StatusRequest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.slotsModel?.slots == null ||
            controller.slotsModel!.slots!.isEmpty) {
          return const Center(child: Text("لا يوجد أوقات متاحة"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "اختر الوقت",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            //  SizedBox(height: 15,),
              // --- شبكة الأوقات ---
              GridView.builder(
                shrinkWrap:  true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.slotsModel!.slots!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5, // لتجعل الشكل بيضوي متناسق
                ),
                itemBuilder: (context, index) {
                  final slot = controller.slotsModel!.slots![index];
                  final isSelected = controller.selectedIndex == index;

                  return  GestureDetector(
                    onTap: () => controller.selectTime(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.secondyColor // 👈 نفس لون الاختيار
                            : AppColor.secondyColor.withOpacity(0.08), // 👈 نفس الخلفية الخفيفة
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.secondyColor
                              : Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        slot.startTime ?? "",
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white // 👈 نفس النص بالأيام
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }


}