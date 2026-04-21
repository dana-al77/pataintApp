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
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // خفيف كتير (طبي)
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(0, 8), // ظل لتحت
            ),
          ],
        ),        child: Material(
        elevation: 5,
        shadowColor: AppColor.backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent, // لجعل الخلفية تعتمد على الـ TextField
          child: TextFormField(
            keyboardType: isNumber
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            validator: valid,
          
            controller: mycontroller,
            obscureText:
                obscureText == null || obscureText == false ? false : true,
            //  readOnly: onTapIcon != null, // إذا في onTapIcon، خليه بس للقراءة
            onTap: onTapIcon,
          
            style: TextStyle(
                color: Colors.black, fontSize: 14), // ← لون النص المُدخل
          
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.backgroundColor,
              hintText: hindtext,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
              prefixIconConstraints: BoxConstraints(
                minWidth: 22,
                minHeight: 35,
              ),
              // التعديل الأهم هنا: auto تجعل النص يرتفع فقط عند التفاعل
              floatingLabelBehavior: FloatingLabelBehavior.auto,
          
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              // الـ Label الذي سيظهر بالأعلى عند الضغط
              labelText: labeltext,
              labelStyle: const TextStyle(fontSize: 16, color: AppColor.thirdColor),

              // هنا نضيف prefixText لو موجود
              prefixText: prefixText != null ? prefixText : null,
              prefixStyle: const TextStyle(color: Colors.black, fontSize: 14),

              prefixIcon: Padding(
                padding: const EdgeInsets.only(right:10,),
                child: Icon(
                  iconData,
                  color: AppColor.thirdColor,
                ),
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
              // شكل الحدود الدائرية كما في الصورة
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), // تقليل القيمة لجعل الزوايا انسيابية
                borderSide:  BorderSide(color:Colors.blue.shade100.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColor.thirdColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
