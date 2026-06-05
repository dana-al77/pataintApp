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