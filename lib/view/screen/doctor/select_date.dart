// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:patientapp/core/constant/color.dart';
// import '../../../controller/appiontement/appiontement_controller.dart';
// import '../../../data/model/doctor.dart';
//
// class ScheduleDateWidget extends StatelessWidget {
//   final DoctorModel doctor;
//
//   const ScheduleDateWidget({super.key, required this.doctor});
//
//   /// 🔹 تنظيف اسم اليوم (مثل TUE, MON)
//   String formatDay(String day) {
//     if (day.startsWith("ال")) {
//       return day.substring(2).toUpperCase();
//     }
//     return day.toUpperCase();
//   }
//
//   /// 🔹 استخراج رقم اليوم
//   String extractDayNumber(String date) {
//     try {
//       return date.split("-").last;
//     } catch (e) {
//       return date;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AppointmentController>(
//       builder: (controller) {
//         if (doctor.schedules == null || doctor.schedules!.isEmpty) {
//           return const Center(child: Text("لا يوجد مواعيد"));
//         }
//
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- قسم التاريخ Date ---
//               const Text(
//                 "اختر اليوم",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               SizedBox(
//                 height: 85,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: doctor.schedules!.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 10),
//                   itemBuilder: (context, index) {
//                     final schedule = doctor.schedules![index];
//                     final isSelected = controller.selectedDate == schedule.date;
//
//                     return GestureDetector(
//                       onTap: () {
//                         controller.selectDate(
//                           doctor.doctorId!,
//                           schedule.date!,
//                         );
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         width: 65,
//                         height: 65, // 👈 مهم جداً (دائرة)
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? AppColor.secondyColor.withOpacity(0.1)
//                               : Colors.white,
//                           shape: BoxShape.circle, // 👈 بدل borderRadius
//                           border: Border.all(
//                             color: isSelected
//                                 ? AppColor.secondyColor
//                                 : Colors.grey.shade300,
//                             width: 2,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             /// اليوم
//                             Text(
//                               formatDay(schedule.day ?? ""),
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: isSelected
//                                     ? AppColor.secondyColor
//                                     : Colors.grey,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//
//                             const SizedBox(height: 4),
//
//                             /// الرقم
//                             Text(
//                               extractDayNumber(schedule.date ?? ""),
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: isSelected
//                                     ? AppColor.secondyColor
//                                     : Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//
//
//
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../../controller/appiontement/appiontement_controller.dart';
import '../../../data/model/doctor.dart';

class ScheduleDateWidget extends StatelessWidget {
  final DoctorModel doctor;

  const ScheduleDateWidget({super.key, required this.doctor});

  String formatDay(String day) {
    if (day.startsWith("ال")) {
      return day.substring(2).toUpperCase();
    }
    return day.toUpperCase();
  }

  String extractDayNumber(String date) {
    try {
      return date.split("-").last;
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        if (doctor.schedules == null || doctor.schedules!.isEmpty) {
          return const Center(child: Text("لا يوجد مواعيد"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "اختر اليوم",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100, // الارتفاع الكلي للمنطقة
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctor.schedules!.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final schedule = doctor.schedules![index];
                    final isSelected = controller.selectedDate == schedule.date;



                    return GestureDetector(
                      onTap: () {
                        controller.selectDate(doctor.doctorId!, schedule.date!);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 50,
                        height: 80, // 🔹 إضافة ارتفاع ثابت هنا لحل المشكلة
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.secondyColor : AppColor.secondyColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected ? AppColor.secondyColor : Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // 🔹 توسيط العناصر عمودياً
                          children: [
                            Text(
                              formatDay(schedule.day ?? ""),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[900],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8), // مسافة ثابتة بين النص والدائرة
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                                border: isSelected
                                    ? null
                                    : Border.all(color: Colors.grey.withOpacity(0.2)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                extractDayNumber(schedule.date ?? ""),
                                style: TextStyle(
                                  color: isSelected ? AppColor.secondyColor : Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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