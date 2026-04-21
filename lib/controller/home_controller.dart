
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
  bool isSearch = false;
  List<MedicalTip> searchList = [];
  TextEditingController searchController = TextEditingController();
  /////////////////////////
  //HomeData homedata =HomeData(Get.find());



  // List<MedicalTip> tips = [
  //   MedicalTip(
  //     title: "اشرب الماء بكثرة",
  //     content: "يساعد شرب الماء على تحسين الدورة الدموية.",
  //     createdBy: "أحمد",
  //   ),
  //   MedicalTip(
  //     title: "نوم كافي",
  //     content: "الحصول على نوم كافي يحسن الصحة النفسية.",
  //     createdBy: "سارة",
  //   ),
  //   MedicalTip(
  //     title: "نوم كافي",
  //     content: "الحصول على نوم كافي يحسن الصحة النفسية.",
  //     createdBy: "سارة",
  //   ),
  // ];
  // داخل HomeControllerImp
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
  //
  //
  //
  void checkSearch(String val) {
    if (val.isEmpty) {
      isSearch = false;
    } else {
      isSearch = true;
    }
    update();
  }

  void clearSearch() {
    searchController.clear();
    isSearch = false;
    searchList.clear();
    update();
  }
///////////////////////
  void searchData() {
 /*   String keyword = searchController.text.toLowerCase();

    searchList.clear();

    searchList.addAll(
      tips.where((tip) =>
      tip.title?.toLowerCase().contains(keyword) ||
          tip.content.toLowerCase().contains(keyword)),
    );*/

    update();
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

    initialData();

  }


}