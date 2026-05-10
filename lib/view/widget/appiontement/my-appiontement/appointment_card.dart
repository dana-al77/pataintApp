import 'package:flutter/material.dart';
import '../../../../controller/appiontement/my_appointments_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../data/model/my-appiontement.dart';
import 'package:get/get.dart';

import '../dilaog.dart';
class AppointmentCard extends StatelessWidget {
  final MyAppointmentModel appointment;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          // --- القسم العلوي: صورة الطبيب، المعلومات، الحالة، وأيقونة الإلغاء ---
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: appointment.doctorImage != null
                    ? Image.network(
                  appointment.doctorImage!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 60,
                  height: 60,
                  color: AppColor.secondyColor.withOpacity(0.2),
                  child: Icon(Icons.person, color: AppColor.secondyColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "د. ${appointment.doctorName}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.specialization ?? "",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // عمود جانبي يحتوي على أيقونة الإلغاء (إذا وجدت) وتاغ الحالة
              // داخل الـ Column الجانبي
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // تاغ الحالة بشكل Stadium (حبة دواء)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor().withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20), //StadiumBorder
                      border: Border.all(color: statusColor().withOpacity(0.2), width: 0.5),
                    ),
                    child: Text(
                      statusText(),
                      style: TextStyle(
                        color: statusColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  if (onCancel != null)

                         IconButton(
                          onPressed: () {
                            showCustomConfirmDialog(
                              title: "إلغاء الموعد",
                              message: "هل أنتِ متأكدة من رغبتكِ في إلغاء هذا الموعد؟",
                              icon: Icons.delete_forever_rounded,
                              iconColor: Colors.red,
                              confirmBtnText: "نعم، إلغاء",
                              onConfirm: () {
                                onCancel!();
                                Get.back();
                              },                            );

                          },
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.delete_sweep_outlined, color: Colors.red, size: 25),
                          ),
                        )


 ]
              )
            ],
          ),

          const SizedBox(height: 16),

          // --- القسم الأوسط: مستطيل التاريخ والوقت (بدون ثواني) ---
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.secondyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // التاريخ
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,
                        size: 18, color: Colors.blueGrey.shade700),
                    const SizedBox(width: 6),
                    Text(
                      appointment.date ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // فاصل عمودي
                Container(height: 15, width: 1, color: Colors.grey.shade300),

                // الوقت (تم قص الثواني باستخدام substring)
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 18, color: Colors.blueGrey.shade700),
                    const SizedBox(width: 6),
                    Text(
                      "${appointment.startTime?.substring(0, 5)} - ${appointment.endTime?.substring(0, 5)}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- الدوال المساعدة للحالة ---

  String statusText() {
    switch (appointment.status) {
      case "confirmed":
        return "مؤكد";
      case "pending":
        return "قادم";
      case "cancelled":
        return "ملغي";
      default:
        return "";
    }
  }

  Color statusColor() {
    switch (appointment.status) {
      case "confirmed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}