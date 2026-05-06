import 'dart:io';

import 'package:flutter/material.dart';
import '../../../controller/profile/profile_controller.dart';
import '../../../core/constant/color.dart';
import '../../../data/model/profile/profile_model.dart';

// class ProfileAvatar extends StatelessWidget {
//   final ProfileController controller;
//   ProfileAvatar({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 45,
//           backgroundColor: Colors.grey.withOpacity(0.15),
//
//           child: ClipOval(
//             child: (controller.profileModel?.profileImage != null )
//                 ? Image.network(
//               controller.profileModel!.profileImage !,
//               width: 90,
//               height: 90,
//               fit: BoxFit.cover,
//
//               errorBuilder: (context, error, stackTrace) {
//                 return Icon(
//                   Icons.person,
//                   size: 60,
//                   color: AppColor.grey,
//                 );
//               },
//             )
//                 : Icon(
//               Icons.person,
//               size: 60,
//               color: AppColor.grey,
//             ),
//           ),
//         ),
//
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: Container(
//             padding: const EdgeInsets.all(6),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.camera_alt,
//               size: 16,
//               color: AppColor.secondyColor,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl; // 🔥 رابط الصورة من السيرفر
  final File? imageFile; // 🔥 الصورة الجديدة (إذا المستخدم اختار)
  final bool isEditing;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.isEditing = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.withOpacity(0.15),
          child: ClipOval(
            child: imageFile != null
                ? Image.file(
              imageFile!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
                : (imageUrl != null && imageUrl!.isNotEmpty)
                ? Image.network(
              imageUrl!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(Icons.person, size: 60);
              },
            )
                : const Icon(Icons.person, size: 60),
          ),
        ),

        /// 🔥 زر الكاميرا يظهر فقط بالتعديل
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: AppColor.secondyColor,
                ),
              ),
            ),
          )
      ],
    );
  }
}