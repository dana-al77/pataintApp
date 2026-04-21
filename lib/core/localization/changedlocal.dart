import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_theme.dart';
import '../functions/fcmconfig.dart';
import '../services/services.dart';

//class LocaleController extends GetxController{

  // Locale? language;
  //
  // MyServices myServices =Get.find();
  // ThemeData appTheme = themeEnglish;
  // changedLang(String langcode)
  // {
  //   Locale locale =Locale(langcode);
  //   myServices.sharedPreferences.setString("lang", langcode);
  //   appTheme = langcode == "ar" ?themeArabic :themeEnglish ;
  //   Get.changeTheme(appTheme);
  //   Get.updateLocale(locale);
  // }
  //
  // @override
  // void onInit() {
  //   // requestPermissionNotification();
  //   // fcmconfig();
  //   String? shraedPrefLang =myServices.sharedPreferences.getString("lang");
  //   if(shraedPrefLang == "ar"){
  //     language =const Locale("ar");
  //     appTheme= themeArabic;
  //   }
  //   else if(shraedPrefLang == "en"){
  //     language =const Locale("en");
  //     appTheme=themeEnglish ;
  //   }
  //   else{
  //     language =Locale(Get.deviceLocale!.languageCode);
  //   }
  //   super.onInit();
  // }
  class LocaleController extends GetxController {


  Locale language = const Locale("ar");


  ThemeData appTheme = themeArabic;

  @override
  void onInit() {
  super.onInit();
  }
  }
//}