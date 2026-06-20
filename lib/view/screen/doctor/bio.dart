// import 'package:flutter/material.dart';
//
// class DoctorBio extends StatefulWidget {
//   final String? bio;
//
//   const DoctorBio({super.key, this.bio});
//
//   @override
//   State<DoctorBio> createState() => _DoctorBioState();
// }
//
// class _DoctorBioState extends State<DoctorBio> {
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.bio == null || widget.bio!.isEmpty) {
//       return const SizedBox();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           /// 🔹 العنوان
//           const Text(
//             "نبذة عن الطبيب",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           /// 🔹 النص
//           Text(
//             widget.bio!,
//             maxLines: isExpanded ? null : 2,
//             overflow:
//             isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
//             style: TextStyle(
//               color: Colors.grey[700],
//               height: 1.4,
//             ),
//           ),
//
//           /// 🔹 زر عرض المزيد
//           if (widget.bio!.length > 80)
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 5),
//                 child: Text(
//                   isExpanded ? "عرض أقل" : "عرض المزيد",
//                   style: const TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/color.dart';

class DoctorBio extends StatefulWidget {
  final String? bio;

  const DoctorBio({
    super.key,
    this.bio,
  });

  @override
  State<DoctorBio> createState() => _DoctorBioState();
}

class _DoctorBioState extends State<DoctorBio> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.bio == null || widget.bio!.trim().isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColor.secondyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "نبذة عن الطبيب",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Content Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  Icons.format_quote,
                  size: 28,
                  color: AppColor.secondyColor.withOpacity(0.35),
                ),

                const SizedBox(height: 8),


                Text(
                 // "هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً هذا نص طويل جداً",
                  widget.bio!,
                  maxLines: isExpanded ? null : 3,
                  overflow: isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14.5,
                    height: 1.8,
                  ),
                ),
                // /// هون حطيها
                // const SizedBox(height: 12),
                //
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Transform.rotate(
                //     angle: 3.14,
                //     child: Icon(
                //       Icons.format_quote,
                //       size: 28,
                //       color: AppColor.secondyColor.withOpacity(0.35),
                //     ),
                //   ),
                // ),
                if (widget.bio!.length > 12) ...[
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isExpanded ? "عرض أقل" : "عرض المزيد",
                              style: TextStyle(
                                color: AppColor.secondyColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColor.secondyColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}