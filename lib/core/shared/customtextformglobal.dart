
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

class CustomTextFormGlobal extends StatelessWidget {
  final String hindtext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final  bool isNumber ;
  final bool? obscureText;
  final void Function()? onTapIcon;
  const CustomTextFormGlobal({super.key,
    this.obscureText,
    this.onTapIcon,
    required this.hindtext, required this.labeltext,
    required this.iconData,
    required this.mycontroller, required this.valid, required this.isNumber
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: isNumber ? TextInputType.numberWithOptions(decimal: true): TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false  ? false : true,
        style: TextStyle(color: Colors.black,fontSize: 18), // ← لون النص المُدخل

        decoration: InputDecoration(
          hintText: hindtext,
          hintStyle: TextStyle(fontSize: 17),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
          label: Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: Text(labeltext,style: TextStyle(fontSize: 20),)
          ),
          suffixIcon: InkWell(
              onTap:onTapIcon ,
              child: Icon(iconData)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColor.primaryColor, // ← غيّر اللون حسب الرغبة (مثلاً AppColor.primaryColor)
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
