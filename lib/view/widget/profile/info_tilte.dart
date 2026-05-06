import 'package:flutter/material.dart';
import 'icon_box.dart';
//
// class InfoRowTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final Color iconColor;
//   final Color iconBackground;
//
//   const InfoRowTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     this.iconColor = Colors.blue,
//     this.iconBackground = const Color(0x1A2196F3),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//
//           // 🔥 هنا بدل Icon صار Container Icon
//           IconBox(
//             icon: icon,
//             color: iconColor,
//             backgroundColor: iconBackground,
//           ),
//
//           const SizedBox(width: 15),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//
//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 16,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
// }
class InfoRowTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  final Widget? editableChild;
  final bool isEditing;

  final IconData? trailingIcon; // 🔥 جديد
  final VoidCallback? onTrailingTap; // 🔥 جديد

  final Color iconColor;
  final Color iconBackground;

  const InfoRowTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.editableChild,
    this.isEditing = false,
    this.trailingIcon,
    this.onTrailingTap,
    this.iconColor = Colors.blue,
    this.iconBackground = const Color(0x1A2196F3),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconBox(
            icon: icon,
            color: iconColor,
            backgroundColor: iconBackground,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),

                isEditing
                    ? editableChild!
                    : Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          /// 🔥 هون التغيير
          if (isEditing)
            const SizedBox() // 🔥 وقت التعديل ما بدنا أيقونة
          else if (trailingIcon != null)
            GestureDetector(
              onTap: onTrailingTap,
              child: Icon(
                trailingIcon,
                size: 18,
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}