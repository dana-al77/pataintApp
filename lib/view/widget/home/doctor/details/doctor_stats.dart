
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../controller/review_controller.dart';
import '../../../../../core/constant/color.dart';
import 'package:get/get.dart';
class DoctorStats extends StatelessWidget {
  final doctor;
  final ReviewController reviewController;
  const DoctorStats({
    super.key,
    required this.doctor,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // قوة تأثير التغبيش الزجاجي
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              // لون أبيض شفاف جداً ليعطي إحساس الزجاج
              color: AppColor.blueColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              // حدود خفيفة وناعمة لتبين حواف البطاقة الزجاجية
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _stat(Icons.people, "2456", "مريض", Colors.green)),
               // _divider(),
                Expanded(
                  child: GetBuilder<ReviewController>(

                    builder: (controller) {

                      return _stat(
                        Icons.star,
                        controller.totalReviews.toString(),
                        "تقييم",
                        Colors.orange,
                      );
                    },
                  ),
                ),
                // _divider(),
                Expanded(child: _stat(Icons.work, "${doctor.experienceYears ?? 0}", "سنوات", Colors.blue)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _stat(IconData icon, String value, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // لتوسيط العناصر داخل العمود بالتساوي
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // أو Colors.white إذا كانت الخلفية داكنة جداً
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
