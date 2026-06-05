import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/profile/profile_data.dart';
import '../../data/model/profile/profile_model.dart';


class EditProfileController extends GetxController {

  /// 📌 الحالة
  StatusRequest statusRequest = StatusRequest.none;

  /// 📌 Data
  late ProfileModel profileModel;
  ProfileData profileData = ProfileData(Get.find());


  late TextEditingController dateOfBirth;
  late TextEditingController emergencyContact;
  late TextEditingController phone;

  /// 📌 Dropdown values
  String? selectedGovernorate;
  String? selectedCity;
  String? selectedGender;
  File? imageFile;
  String? editingField;


  final ImagePicker picker = ImagePicker();

  pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageFile = File(picked.path);
      update();
    }
  }
  /// 📌 المحافظات والمدن
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
  void startEditing(String field) {
    editingField = field;
    update();
  }

  void stopEditing() {
    editingField = null;
    update();
  }

  List<String> get cities =>
      selectedGovernorate != null
          ? governoratesAndCities[selectedGovernorate!]!
          : [];

  /// 🔄 تغيير المحافظة
  void changeGovernorate(String? value) {
    selectedGovernorate = value;
    selectedCity = null;
    update();
  }

  /// 🔄 تغيير المدينة
  void changeCity(String? value) {
    selectedCity = value;
    update();
  }

  /// 🔄 تغيير الجنس
  void changeGender(String? value) {
    selectedGender = value;
    update();
  }

  updateProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await profileData.updateData({
        "date_of_birth": dateOfBirth.text,
        "country": selectedGovernorate,
        "city": selectedCity,
        "emergency_contact": emergencyContact.text,
        "phone":phone.text
      }, imageFile: imageFile,
      );

      print("===== UPDATE RESPONSE $response");

      /// 🔥 تجاهل handlingData هون مؤقتاً
      if (response['success'] == true) {

        /// 1. رجوع أولاً
        Get.back(result: true);

        /// 2. بعد الرجوع اعرض Snackbar
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.snackbar(
            "Success",
            "Profile updated",
            snackPosition: SnackPosition.BOTTOM,
          );
        });

      } else {
        Get.snackbar("Error", "Update failed");
      }

    } catch (e) {
      print("❌ ERROR: $e");
      Get.snackbar("Error", "Something went wrong");
    }

    statusRequest = StatusRequest.none;
    update();
  }
  @override
  void onInit() {
    profileModel = Get.arguments;

    dateOfBirth = TextEditingController(
        text: profileModel.patient?.dateOfBirth);

    emergencyContact = TextEditingController(
        text: profileModel.patient?.emergencyContact);

    phone = TextEditingController(
        text: profileModel.phone);

    selectedGovernorate = profileModel.patient?.country;

    // تحقق من المحافظة
    if (governoratesAndCities.containsKey(selectedGovernorate)) {
      final citiesList = governoratesAndCities[selectedGovernorate!]!;

      selectedCity = citiesList.contains(profileModel.patient?.city)
          ? profileModel.patient?.city
          : null;
    } else {
      selectedGovernorate = null;
      selectedCity = null;
    }

    super.onInit();
  }
  //
  // @override
  // void onInit() {
  //   profileModel = Get.arguments;
  //
  //   dateOfBirth = TextEditingController(
  //       text: profileModel.patient?.dateOfBirth);
  //
  //   emergencyContact = TextEditingController(
  //       text: profileModel.patient?.emergencyContact);
  //
  //   selectedGovernorate = profileModel.patient?.country;
  //
  //
  //   // 🔥 تأكد المحافظة موجودة
  //   if (!governoratesAndCities.containsKey(selectedGovernorate)) {
  //     selectedGovernorate = null;
  //     selectedCity = null;
  //   } else {
  //     final citiesList = governoratesAndCities[selectedGovernorate!]!;
  //
  //     selectedCity = citiesList.contains(profileModel.patient?.city)
  //         ? profileModel.patient?.city
  //         : null;
  //   }
  //   selectedCity = profileModel.patient?.city;
  //   super.onInit();
  // }
  /// 🧹 dispose
  @override
  void dispose() {
    dateOfBirth.dispose();
    emergencyContact.dispose();
    phone.dispose();
    super.dispose();
  }
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dateOfBirth.text =
      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      update();
    }
  }
}