import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/routes.dart';
import '../../../core/constant/color.dart';

class DoctorConsultationCard extends StatelessWidget {
  const DoctorConsultationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 175,
      decoration: BoxDecoration(
        // استخدام لون أخضر تيل فاتح جداً كما في الصورة
        color: AppColor.secondyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // نصوص الكارد والزر
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "هل تبحث عن طبيب متخصص؟",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 180, // تحديد العرض لكي لا يغطي النص صورة الطبيب
                  child: Text(
                    "دعنا نتواصل مع الطبيب، أخبره عن حالتك ونحن نتولى الباقي...!",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // زر التواصل
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.chat);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColor.secondyColor, // لون الزر الأخضر
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text(
                    "دعنا نتواصل",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // صورة الطبيب (توضع في جهة اليسار أو اليمين حسب اتجاه اللغة)
          Positioned(
            left: 10, // اترك مسافة بسيطة من الحافة
            bottom: 0,
            child: Image.asset(
              'assets/images/doctora-removebg-preview.png', // تأكد من إضافة صورة الطبيب الشفافة هنا
              height: 170,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}