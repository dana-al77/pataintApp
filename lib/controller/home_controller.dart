
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';
import '../data/model/medical_tip.dart';

abstract class HomeController extends GetxController{
  initialData();
  void logout();

}
class HomeControllerImp extends HomeController{
  MyServices myServices= Get.find();


  String? lang;
  String? name;
  String? id;
// 🔍 البحث
  String? imagePath;
  List doctors = [
    // مثال لبيانات تجريبية، يفضل استخدام Model لاحقاً
    {
      "name": "حمزة طارق",
      "specialty": "جراح عظام",
      "experience": 10,
      "rating": 4.9
    },
    {
      "name": "سارة أحمد",
      "specialty": "أخصائية نفسية",
      "experience": 8,
      "rating": 4.8
    },
  ];
  void logout() async {

    await myServices.sharedPreferences.clear();

    Get.offAllNamed("/");
  }

  seeAllDoctor () {
  Get.toNamed(AppRoute.AllDoctor);
}
  ////////////////////////////////
  @override
  initialData(){
   // lang = myServices.sharedPreferences.getString("lang");
    name =myServices.sharedPreferences.getString("name");
    id = myServices.sharedPreferences.getString("id");
  }
  @override
  void onInit() {
    super.onInit();
    imagePath = Get.find<MyServices>()
        .sharedPreferences
        .getString("profile_image");
    initialData();

  }


}