// import 'package:flutter/material.dart';
//
// import '../../../../core/constant/color.dart';
//
// class InfoItemRow extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String? value;
//
//   const InfoItemRow({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (value == null || value!.isEmpty) return const SizedBox.shrink();
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color:AppColor.prim2, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(
//                   color: Colors.black87,
//                   fontSize: 14,
//                 ),
//                 children: [
//                   WidgetSpan(
//                     child: ShaderMask(
//                       shaderCallback: (bounds) {
//                         return LinearGradient(
//                           colors: AppColor.serviceGradient,
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ).createShader(bounds);
//                       },
//                       child: Text(
//                         "$title: ",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   TextSpan(
//                     text: value,
//                     style: const TextStyle(color: AppColor.black,fontSize: 16,fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:patientapp/data/model/center_info.dart';
import 'package:patientapp/data/model/work_houre.dart';

import '../../../../core/constant/color.dart';

class CenterInfoCard extends StatelessWidget {
  final CenterInfo center;

  const CenterInfoCard({
    super.key,
    required this.center,
  });

  String formatWorkingHours(List<WorkingHour>? hours) {
    if (hours == null || hours.isEmpty) {
      return "لا يوجد دوام";
    }

    final openDays = hours.where((e) => e.isClosed == false).toList();

    if (openDays.isEmpty) {
      return "مغلق";
    }

    return "${openDays.first.startTime?.substring(0, 5)} - ${openDays.first.endTime?.substring(0, 5)}";
  }

  @override
  Widget build(BuildContext context) {
    final services =
        center.services?.split("-").map((e) => e.trim()).toList() ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [

          /// HEADER
          Container(
            padding: const EdgeInsets.all(18),
            decoration:  BoxDecoration(
              color: AppColor.secondyColor.withOpacity(0.8),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        center.location ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        center.addressOnMap ?? "",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),
                    ],
                  ),
                ),


            ]),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                /// SERVICES
                const Row(
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "الخدمات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: services
                      .map(
                        (e) => Chip(
                      label: Text(e),
                    ),
                  )
                      .toList(),
                ),

                const SizedBox(height: 20),

                const Divider(),

             //   const SizedBox(height: 10),

                /// PHONE
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xffE8F5E9),
                    child: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                  title: const Text("الهاتف"),
                  subtitle: Text(
                    center.contact ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      // Call
                    },
                   // icon: const Icon(Icons.call, size: 18),
                    label: const Text("اتصال",style: TextStyle(color: AppColor.secondyColor),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD8E6F7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                        //


                /// ADDRESS
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   leading: const CircleAvatar(
                //     backgroundColor:
                //     Color(0xffFFF3E0),
                //     child: Icon(
                //       Icons.location_on,
                //       color: Colors.orange,
                //     ),
                //   ),
                //   title: const Text("العنوان"),
                //   subtitle: Text(
                //     center.addressOnMap ?? "",
                //   ),
                // ),

                //const Divider(),

                const SizedBox(height: 10),

                /// WORKING HOURS
    Container(
    decoration: BoxDecoration(
    color: const Color(0xffF5F8FD),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
    color: const Color(0xffD8E6F7),
    ),
    ),
    child: Theme(
    data: Theme.of(context).copyWith(
    dividerColor: Colors.transparent,
    ),
    child: ExpansionTile(
    tilePadding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 4,
    ),
    childrenPadding: EdgeInsets.zero,
    leading: const Icon(
    Icons.access_time,
    color: Color(0xff1565C0),
    ),
    title: const Text(
    "أوقات الدوام",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xff1565C0),
    ),
    ),

    children: [
    ...center.workingHours!.map(
    (hour) => _buildWorkingHourRow(hour),
    ),
    ],
    ),
    ),
    ),

                const SizedBox(height: 20),

                /// BUTTONS
                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton.icon(
                //         onPressed: () {},
                //         icon: const Icon(Icons.phone),
                //         label:
                //         const Text("اتصال"),
                //       ),
                //     ),
                //
                //     const SizedBox(width: 10),
                //
                //     Expanded(
                //       child: OutlinedButton.icon(
                //         onPressed: () {},
                //         icon: const Icon(
                //             Icons.map_outlined),
                //         label:
                //         const Text("الخريطة"),
                //       ),
                //     ),
                //
                //     const SizedBox(width: 10),
                //
                //     Expanded(
                //       child: FilledButton.tonalIcon(
                //         onPressed: () {},
                //         icon:
                //         const Icon(Icons.info),
                //         label:
                //         const Text("التفاصيل"),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWorkingHourRow(WorkingHour hour) {
    final isClosed = hour.isClosed == true;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffEEEEEE),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isClosed
                  ? Colors.red.shade50
                  : Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                hour.day!
                    .substring(0, 3)
                    .toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isClosed
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              translateDay(hour.day ?? ""),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          if (isClosed)
            const Text(
              "مغلق",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(
              "${hour.startTime!.substring(0, 5)} - ${hour.endTime!.substring(0, 5)}",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
  String translateDay(String day) {
    switch (day) {
      case "Saturday":
        return "السبت";
      case "Sunday":
        return "الأحد";
      case "Monday":
        return "الاثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الأربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      default:
        return day;
    }
  }
}