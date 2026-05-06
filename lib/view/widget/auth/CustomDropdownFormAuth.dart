// import 'package:flutter/material.dart';
// import '../../../core/constant/color.dart';
//
// class CustomDropdownFormAuth<T> extends StatelessWidget {
//   final String hindtext;
//   final String labeltext;
//   final IconData? iconData;
//   final T? value;
//   final List<DropdownMenuItem<T>> items;
//   final void Function(T?)? onChanged;
//   final String? Function(T?)? validator;
//
//   const CustomDropdownFormAuth({
//     super.key,
//     required this.hindtext,
//     required this.labeltext,
//     this.iconData,
//     this.value,
//     required this.items,
//     this.onChanged,
//     this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 5),
//      //   width: MediaQuery.of(context).size.width * 0.9,
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
//         child: DropdownButtonFormField<T>(
//           isExpanded: true,
//           value: value,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: AppColor.backgroundColor,
//             hintText: hindtext,
//             hintStyle: const TextStyle(fontSize: 17, color: Colors.grey),
//             floatingLabelBehavior: FloatingLabelBehavior.auto,
//             labelText: labeltext,
//             labelStyle: const TextStyle(fontSize: 18, color: AppColor.thirdColor),
//             prefixIcon: iconData != null
//                 ? Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Icon(iconData, color: AppColor.thirdColor),
//             )
//                 : null,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(
//                 color: AppColor.thirdColor,
//                 width: 1.5,
//               ),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           ),
//           items: items,
//           onChanged: onChanged,
//           validator: validator,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../../core/constant/color.dart';
//
// class CustomDropdownFormAuth<T> extends StatelessWidget {
//   final String hindtext;
//   final String labeltext;
//   final IconData? iconData;
//   final T? value;
//   final List<DropdownMenuItem<T>> items;
//   final void Function(T?)? onChanged;
//   final String? Function(T?)? valid;
//
//   const CustomDropdownFormAuth({
//     super.key,
//     required this.hindtext,
//     required this.labeltext,
//     this.iconData,
//     this.value,
//     required this.items,
//     this.onChanged,
//     this.valid,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: AppColor.backgroundColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: DropdownButtonFormField<T>(
//         isExpanded: true,
//         value: value,
//         // --- تحسينات شكل القائمة المنبثقة ---
//         dropdownColor: AppColor.backgroundColor, // لون خلفية القائمة عند الفتح
//        // borderRadius: BorderRadius.circular(15), // جعل زوايا القائمة دائرية
//         elevation: 8, // قوة الظل تحت القائمة المنبثقة
//         icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: AppColor.thirdColor, size: 20),
//         style: const TextStyle(fontSize: 16, color: AppColor.black, ),
//
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.transparent,
//           hintText: hindtext,
//           hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//           labelText: labeltext,
//           labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.thirdColor),
//           prefixIcon: iconData != null
//               ? Icon(iconData, color: AppColor.thirdColor, size: 22)
//               : null,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//
//
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: const BorderSide(color: AppColor.thirdColor, width: 1.5),
//           ),
//         ),
//
//         items: items,
//         onChanged: onChanged,
//         validator: valid,
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class CustomDropdownFormAuth<T> extends StatelessWidget {
  final String hindtext;
  final String labeltext;
  final IconData? iconData;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? valid;

  const CustomDropdownFormAuth({
    super.key,
    required this.hindtext,
    required this.labeltext,
    this.iconData,
    this.value,
    required this.items,
    this.onChanged,
    this.valid,
  });

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

              /// 🎨 نفس التدرج
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

            child: DropdownButtonFormField<T>(
              isExpanded: true,
              value: value,

              /// ✨ شكل القائمة المنبثقة (قريب للزجاج)
              dropdownColor: Colors.white.withOpacity(0.95),
              elevation: 6,

              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.thirdColor,
              ),

              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),

              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.transparent,

                hintText: hindtext,
                hintStyle: const TextStyle(color: Colors.black45),

                labelText: labeltext,
                labelStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),

                floatingLabelStyle: TextStyle(
                  color: AppColor.secondyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),

                prefixIcon: iconData != null
                    ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    iconData,
                    color: AppColor.secondyColor,
                  ),
                )
                    : null,

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

              items: items,
              onChanged: onChanged,
              validator: valid,
            ),
          ),
        ),
      ),
    );
  }
}