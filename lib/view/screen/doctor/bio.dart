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
    if (widget.bio == null || widget.bio!.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// العنوان
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.secondyColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: AppColor.secondyColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                "نبذة عن الطبيب",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

        

          const SizedBox(height: 16),

          /// النص
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),

            firstChild: Text(
              widget.bio!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.8,
                fontSize: 14.5,
              ),
            ),

            secondChild: Text(
              widget.bio!,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.8,
                fontSize: 14.5,
              ),
            ),

            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),

          /// زر التوسيع
          if (widget.bio!.length > 120)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "عرض أقل" : "عرض المزيد",
                  style: TextStyle(
                    color: AppColor.secondyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 16,
            color: AppColor.secondyColor,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}