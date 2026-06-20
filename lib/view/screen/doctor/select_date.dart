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

  String formatMonth(String month) {
    switch (month.split('-')[1]) {
      case '01':
        return 'يناير';
      case '02':
        return 'فبراير';
      case '03':
        return 'مارس';
      case '04':
        return 'أبريل';
      case '05':
        return 'مايو';
      case '06':
        return 'يونيو';
      case '07':
        return 'يوليو';
      case '08':
        return 'أغسطس';
      case '09':
        return 'سبتمبر';
      case '10':
        return 'أكتوبر';
      case '11':
        return 'نوفمبر';
      case '12':
        return 'ديسمبر';
      default:
        return month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      builder: (controller) {
        if (doctor.schedules == null || doctor.schedules!.isEmpty) {
          return const Center(
            child: Text("لا يوجد مواعيد"),
          );
        }

        final months = doctor.schedules!
            .map((e) => e.date!.substring(0, 7))
            .toSet()
            .toList();

        if (controller.selectedMonth == null &&
            months.isNotEmpty) {
          controller.selectedMonth = months.first;
        }

        final filteredSchedules = doctor.schedules!
            .where((schedule) => schedule.date!
            .startsWith(controller.selectedMonth!))
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "اختر اليوم",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                     // color: AppColor.secondyColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedMonth,
                        icon: const Icon(
                          Icons.expand_more_rounded,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        items: months.map((month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(
                              formatMonth(month),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.black
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectMonth(value);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredSchedules.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
                  itemBuilder: (context, index) {

                    final schedule =
                    filteredSchedules[index];

                    final isSelected =
                        controller.selectedDate ==
                            schedule.date;

                    return GestureDetector(
                      onTap: () {
                        controller.selectDate(
                          doctor.doctorId!,
                          schedule.date!,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        width: 55,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.secondyColor
                              : AppColor.secondyColor
                              .withOpacity(0.08),
                          borderRadius:
                          BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.secondyColor
                                : Colors.grey
                                .withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Text(
                              formatDay(
                                  schedule.day ?? ""),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              width: 42,
                              height: 42,
                              decoration:
                              BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: isSelected
                                    ? null
                                    : Border.all(
                                  color: Colors
                                      .grey
                                      .withOpacity(
                                      0.2),
                                ),
                              ),
                              alignment:
                              Alignment.center,
                              child: Text(
                                extractDayNumber(
                                  schedule.date ?? "",
                                ),
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColor
                                      .secondyColor
                                      : Colors.black87,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
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