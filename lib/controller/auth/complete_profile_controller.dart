import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import 'complete_profile.dart';

abstract class CompleteProfileController extends GetxController {
  completeProfile();
  goToHome();
  goBacke();
}

class CompleteProfileControllerImp extends CompleteProfileController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController dateOfBirth;
  late TextEditingController emergencyContact;
  late TextEditingController phone;
  String? selectedGovernorate;
  String? selectedCity;
  String? selectedGender;
  StatusRequest statusRequest = StatusRequest.none;

  late CompleteProfileData completeProfileData;

  MyServices myServices = Get.find();


  @override
  completeProfile() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await completeProfileData.postData(
        dateOfBirth: dateOfBirth.text,
        country: selectedGovernorate ?? "",
        city: selectedCity ?? "",
        emergencyContact: emergencyContact.text,
        gender: selectedGender == "ذكر" ? "male" : "female",
        phone: phone.text,
      );

      print("===== Complete Profile Response: $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['message'] == "Profile updated successfully") {

          myServices.sharedPreferences.setString("step", "3");
         Get.toNamed(AppRoute.login);

        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: response['message'] ?? 'Error completing profile',
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {
      print("Form not valid");
    }
  }

  @override
  goToHome() {
  //  Get.offAllNamed(AppRoute.home);
  }
  void skip() {
    myServices.sharedPreferences.setString("step", "3");
    Get.toNamed(AppRoute.login);
  }
  // القيم الثابتة للمحافظات والمدن
  Map<String, List<String>> governoratesAndCities = {
    "دمشق": ["دمشق", "قدسيا", "حرستا", "الكسوة"],
    "حلب": ["حلب", "أعزاز", "منبج", "عفرين"],
    "حماة": ["حماة", "السلمية", "الحميراء"],
    "اللاذقية": ["اللاذقية", "جبلة", "رأس البسيط"],
    "طرطوس": ["طرطوس", "بانياس", "صفوة"],
    "درعا": ["درعا", "نوى", "صيدا"],
    "القنيطرة": ["القنيطرة", "حضر", "جباتا الخشب"],
    "الرقة": ["الرقة", "الطبقة", "الشدادي"],
    "الحسكة": ["الحسكة", "القامشلي", "تل تمر"],
    "إدلب": ["إدلب", "سلقين", "معرة النعمان"],
    "دير الزور": ["دير الزور", "البصيرة", "الميادين"],
    "حمص": ["حمص", "الرستن", "القصير"],
    "سويداء": ["السويداء", "شهبا", "صحراء السويداء"],
  };

  List<String> get cities =>
      selectedGovernorate != null ? governoratesAndCities[selectedGovernorate!]! : [];



  void changeGovernorate(String? value) {
    selectedGovernorate = value;
    selectedCity = null; // reset المدينة لما تتغير المحافظة
    update();
  }

  void changeCity(String? value) {
    selectedCity = value;
    update();
  }
  void changeGender(String? value) {
    selectedGender = value;
    update();
  }

  @override
  goBacke() {
  Get.back();
  }

  @override
  void dispose() {
    dateOfBirth.dispose();
    emergencyContact.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    dateOfBirth = TextEditingController();
    emergencyContact = TextEditingController();
    phone = TextEditingController();

    completeProfileData = CompleteProfileData(Get.find());

    super.onInit();
  }


}