import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hindtext;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final String? prefixText; // اختياري
  const CustomTextFormAuth(
      {super.key,
      this.obscureText,
      this.onTapIcon,
        this.prefixText,
      required this.hindtext,
      required this.labeltext,
      this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
        child:ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),

                // 🎨 لون زجاجي
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                // ✨ بوردر خفيف
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),


                child: TextFormField(
                  keyboardType: isNumber
                      ? TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                  validator: valid,
                  controller: mycontroller,
                  obscureText: obscureText ?? false,

                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  decoration: InputDecoration(
                    // ❌ مهم جداً

                    filled: false,
                    fillColor: Colors.transparent,

                    hintText: hindtext,
                    hintStyle:
                    const TextStyle(color: Colors.black45),

                    labelText: labeltext,
                    labelStyle:
                    const TextStyle(color: Colors.black54,fontSize: 15),
                    floatingLabelStyle: TextStyle(
                      color: AppColor.secondyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),

                    prefixText: prefixText,
                    prefixStyle:
                    const TextStyle(color: Colors.black),

                    prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        iconData,
                        color: AppColor.secondyColor,
                      ),
                    ),

                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 30,
                      minHeight: 30,
                    ),
                    suffixIcon: obscureText != null
                        ? InkWell(
                      onTap: onTapIcon,
                      child: Icon(
                        obscureText == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.thirdColor,
                      ),
                    )
                        : null,
                    alignLabelWithHint: true,
                    // 🔥 هذا أهم شي
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none, // شفاف
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),

                    contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 8),

                  ),

              ),
            ),
          ),
        )
    );
  }
}
