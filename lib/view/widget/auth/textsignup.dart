import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class CustomTextSignUpOrSignIn extends StatelessWidget {
  final String textOne;
  final String textTow;
  final void Function() onTap;
  const CustomTextSignUpOrSignIn({super.key, required this.textOne, required this.textTow,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textOne),
        InkWell(
          onTap:onTap,
          child: Text(textTow,style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.bold),),)
      ],
    );
  }
}
