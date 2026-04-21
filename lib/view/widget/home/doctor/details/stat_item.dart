import 'package:flutter/material.dart';

// class StatItem extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color? iconColor; // 👈 جديد
//
//   const StatItem({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     this.iconColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final color = iconColor ?? Colors.grey[700]; // لون افتراضي
//
//     return Column(
//       children: [
//         /// الأيقونة
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color!.withOpacity(0.1), // خلفية خفيفة من نفس اللون
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             size: 22,
//             color: color,
//           ),
//         ),
//
//         const SizedBox(height: 6),
//
//         /// الرقم
//         Text(
//           value,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//
//         const SizedBox(height: 4),
//
//         /// العنوان
//         Text(
//           title,
//           style: const TextStyle(color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }
Widget buildPill({
  required IconData icon,
  required String value,
  required String label,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(30), // 👈 الشكل الكبسولي
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// الأيقونة
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),

        const SizedBox(width: 8),

        /// النص
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}