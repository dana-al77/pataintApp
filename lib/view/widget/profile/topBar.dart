// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:patientapp/controller/home_controller.dart';
//
// class ProfileTopBar extends StatelessWidget {
//   const ProfileTopBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(HomeControllerImp());
//     return GetBuilder<HomeControllerImp>(
//       builder: (controller) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               // const Icon(Icons.arrow_back, color: Colors.white),
//               // const SizedBox(width: 10),
//               const Text(
//                 "الحساب الشخصي",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(Icons.logout, color: Colors.white,size: 30,),
//                 onPressed: () {
//                   Get.defaultDialog(
//                     title: "تسجيل الخروج",
//                     middleText: "هل أنت متأكد؟",
//                     textCancel: "إلغاء",
//                     textConfirm: "خروج",
//                     confirmTextColor: Colors.white,
//                     onConfirm: () {
//                    controller.logout();
//                     },
//                   );
//                 },
//               )
//
//             ],
//           ),
//         );
//       }
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/controller/home_controller.dart';

class ProfileTopBar extends StatelessWidget {
  final bool isEditPage; // 🔥 هل الصفحة تعديل؟

  const ProfileTopBar({
    super.key,
    this.isEditPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerImp());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          /// 📝 النص حسب الصفحة
          Text(
            isEditPage ? "تعديل الحساب" : "الحساب الشخصي",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          /// 🎯 الأيقونة حسب الصفحة
          IconButton(
            icon: Icon(
              isEditPage ? Icons.arrow_back : Icons.logout,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              if (isEditPage) {
                /// 🔙 رجوع
                Get.back();
              } else {
                /// 🚪 تسجيل خروج
                Get.defaultDialog(
                  title: "تسجيل الخروج",
                  middleText: "هل أنت متأكد؟",
                  textCancel: "إلغاء",
                  textConfirm: "خروج",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.logout();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}