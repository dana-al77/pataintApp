import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class CustomDateField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData? iconData;
  final TextEditingController controller;
  final String? Function(String?) valid;

  const CustomDateField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.iconData,
    required this.controller,
    required this.valid,
  });

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      controller.text =
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: MediaQuery.of(context).size.width * 0.9,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),

              /// 🎨 نفس التدرج تبع التكتفيلد
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              /// ✨ بوردر خفيف
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
              ),
            ),

            child: TextFormField(
              controller: controller,
              validator: valid,

              readOnly: true,
              onTap: () => _selectDate(context),

              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.transparent,

                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black45),

                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),

                floatingLabelStyle: TextStyle(
                  color: AppColor.secondyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),

                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    iconData ?? Icons.calendar_today,
                    color: AppColor.secondyColor,
                  ),
                ),

                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                contentPadding:
                const EdgeInsets.fromLTRB(8, 16, 8, 8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../../core/constant/color.dart';
//
// class CustomDateField extends StatelessWidget {
//   final String hintText;
//   final String labelText;
//   final IconData? iconData;
//   final TextEditingController controller;
//   final String? Function(String?) valid;
//
//   const CustomDateField({
//     super.key,
//     required this.hintText,
//     required this.labelText,
//     this.iconData,
//     required this.controller,
//     required this.valid,
//   });
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime now = DateTime.now();
//
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime(now.year - 18),
//       firstDate: DateTime(1900),
//       lastDate: now,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColor.primaryColor, // اللون الرئيسي (أزرار الـ OK & Cancel)
//               onPrimary: Colors.white, // لون النص على الأزرار
//               onSurface: Colors.black, // لون الأيام
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColor.thirdColor, // لون أزرار TextButton
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//
//     );
//
//     if (picked != null) {
//       controller.text =
//       "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         width: MediaQuery.of(context).size.width * 0.9, // ✅ نفس العرض
//
//         decoration: BoxDecoration(
//           color: AppColor.backgroundColor,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 15,
//               spreadRadius: 1,
//               offset: Offset(0, 8),
//             ),
//           ],
//         ),
//
//         child: Material(
//           elevation: 5,
//           shadowColor: AppColor.backgroundColor.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.transparent,
//
//           child: TextFormField(
//             controller: controller,
//             validator: valid,
//
//             readOnly: true, // 🔥 يمنع الكتابة
//             onTap: () => _selectDate(context),
//
//             style: TextStyle(color: Colors.black, fontSize: 14),
//
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: AppColor.backgroundColor,
//
//               hintText: hintText,
//               hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
//
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//
//               contentPadding:
//               EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//
//               labelText: labelText,
//               labelStyle: const TextStyle(
//                 fontSize: 16,
//                 color: AppColor.thirdColor,
//               ),
//
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Icon(
//                   iconData ?? Icons.calendar_today,
//                   color: AppColor.thirdColor,
//                 ),
//               ),
//
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   color: Colors.blue.shade100.withOpacity(0.5),
//                 ),
//               ),
//
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   color: Colors.blue.shade100.withOpacity(0.5),
//                 ),
//               ),
//
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   color: AppColor.thirdColor,
//                   width: 1.5,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }