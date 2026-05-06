import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../data/datasource/remote/upload_medical_data.dart';


class MedicalTestController extends GetxController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController testType;
  late TextEditingController notes;

  File? file;
  double uploadProgress = 0;
  StatusRequest statusRequest = StatusRequest.none;

  late MedicalTestData medicalTestData;

  MyServices myServices = Get.find();

  // /// 📂 اختيار ملف (صورة أو ملف)
  // Future<void> chooseFile() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (picked != null) {
  //     file = File(picked.path);
  //   }
  //
  //   update();
  // }
  String? fileName;

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      file = File(result.files.single.path!);
      fileName = result.files.single.name;
      // --- محاكاة التحميل ---
      uploadProgress = 0;
      update();

      // أنيميشن بسيط لجعل الشريط يزحف لـ 100%
      for (int i = 0; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 200));
        uploadProgress = i / 10; // تزداد من 0.1 إلى 1.0
        update();
      }
    }

    update();
  }

  /// 🚀 رفع التحليل
  uploadTest() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      if (file == null) {
        Get.snackbar("تنبيه", "اختر ملف أولاً");
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      var response = await medicalTestData.postData(
        testType: testType.text,
        notes: notes.text,
        file: file!,
      );

      print("===== Upload Test Response: $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == true) {

          Get.snackbar("نجاح", "تم رفع التحليل");

        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: response['message'] ?? "Upload failed",
          );
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    }
  }



  @override
  void onInit() {
    testType = TextEditingController();
    notes = TextEditingController();

    medicalTestData = MedicalTestData(Get.find());

    super.onInit();
  }
}