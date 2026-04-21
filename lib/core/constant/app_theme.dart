import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEnglish = ThemeData(
    fontFamily: "PlayfairDisplay",
    textTheme: TextTheme(
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.black),
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyLarge: TextStyle(height: 2,  fontSize: 17),
    ));

ThemeData themeArabic = ThemeData(
    fontFamily: "Cairo",
    textTheme: TextTheme(
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.black),
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyLarge: TextStyle(height: 2,  fontSize: 17),
    ));
