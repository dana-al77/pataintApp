import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../core/constant/color.dart';

class CustomOtpField extends StatelessWidget {
  final int numberOfFields;
  final void Function(String) onSubmit;

  const CustomOtpField({
    super.key,
    this.numberOfFields = 6,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: numberOfFields,
      fieldWidth: 42.0, // عرض متناسق
      fieldHeight: 55.0,
      borderRadius: BorderRadius.circular(15),
      showFieldAsBox: true,
      enabledBorderColor: Colors.blue.shade100.withOpacity(0.5),
      focusedBorderColor: AppColor.thirdColor,
      borderColor: Colors.blue.shade100.withOpacity(0.5),
      // تقليل المارجن لضمان عدم حدوث Overflow
      margin: const EdgeInsets.symmetric(horizontal: 4),
      textStyle: TextStyle(
        color: AppColor.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      onSubmit: onSubmit,
    );
  }
}