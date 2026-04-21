import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/appiontement/appiontement_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';

class BookingButton extends StatelessWidget {
  final int doctorId;

  const BookingButton({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        final isEnabled =
            controller.selectedDate != null &&
                controller.selectedIndex != null;

        return Container(
          margin: EdgeInsets.all(13),
          // الحفاظ على البادينج كما طلبت
         // padding: const EdgeInsets.only(right: 10,),
          child: Row(
            // لضبط حجم الصف حسب المحتوى
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. أيقونة الدردشة داخل دائرة (مثل الصورة)
              // مسافة بين الدائرة والزر

              // 2. زر الحجز (تم تعديل عرضه ليناسب وجود الأيقونة بجانبه)
              GestureDetector(
                onTap: isEnabled
                    ? () {
                  controller.bookAppointment(doctorId);
                }
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 55,
                  // إزالة العرض الثابت width: 170 للسماح بالتمدد المرن
                  // أو يمكنك تفعيله إذا كنت تريد عرضاً ثابتاً دقيقاً
                  width: 250,
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? AppColor.secondyColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30), // دائرية قوية
                    boxShadow: isEnabled
                        ? [
                      BoxShadow(
                        color: AppColor.secondyColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                        : [],
                  ),
                  child: Center(
                    child: controller.statusRequest == StatusRequest.loading
                        ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      isEnabled ? "احجز " : "اختر الوقت أولاً",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),

              Container(
                width: 55, // نفس ارتفاع الزر ليتناسق
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white, // خلفية بيضاء للدائرة
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400, // لون الحافة
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColor.secondyColor, // أو لون رمادي حسب الرغبة
                    size: 26,
                  ),
                  onPressed: () {
                    // منطق فتح الدردشة مع الدكتور هنا
                    print("Open Chat with doctor: $doctorId");
                    // مثال: Get.to(() => ChatScreen(doctorId: doctorId));
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}