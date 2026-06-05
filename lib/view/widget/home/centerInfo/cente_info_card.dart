
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../../../controller/home/center_info.dart';
import '../section_title.dart';

class OpeningHoursCard extends StatelessWidget {
  final Map<String, String> openingHours;

  const OpeningHoursCard( {
    super.key,
    required this.openingHours,
  });

  @override
  Widget build(BuildContext context) {
    ViewCenetrInfoControllerImp  controller= Get.put(ViewCenetrInfoControllerImp());
    String currentDay = controller.getCurrentArabicDay();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Padding(
          padding: EdgeInsets.all(16),
            child: SectionTitle(title: "ساعات العمل",)),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 10), // قللنا البادينغ شوي عشان الخلفية الملونة تطلع أحلى
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              /// DAYS
              ...openingHours.entries.map(
                    (entry) {

                  bool isToday = entry.key.trim() == currentDay.trim();

                  bool isClosed = entry.value.contains("مغلق");
                  Color statusColor = isClosed ? Colors.red : Colors.blue.shade700;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: isToday
                          ? statusColor.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        /// اسم اليوم
                        Expanded(
                          flex: 2,
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                              color: isToday ? statusColor : Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// HOURS (هنا التعديل المطلوب للألوان)
                        Expanded(
                          flex: 3,
                          child: Text(
                            entry.value,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              color: isClosed
                                  ? Colors.red
                                  : (isToday ?AppColor.secondyColor : Colors.grey.shade700),
                              fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )  ]  );
  }
}

