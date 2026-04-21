import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasource/remote/appiontement/firstly_appiontement.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';




class FistAppiontController extends GetxController {
  int currentStep = 0;
  PageController pageController = PageController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController chronicDiseases;
  late TextEditingController allergies;
  late TextEditingController medications;
  late TextEditingController notes;
  late TextEditingController height;
  late TextEditingController weight;
  late TextEditingController bloodType;
  late TextEditingController surgeries;
  late TextEditingController familyHistory;
  late TextEditingController bloodPressure;

  StatusRequest statusRequest = StatusRequest.none;

  FistAppiontData medicalRecordData = FistAppiontData(Get.find());

  bool isSmoker = false;
  bool get isLastStep => currentStep == 3;
  bool isStepCurrent(int index) => currentStep == index;
  bool isStepDone(int index) => currentStep > index;
  void handleNextOrSubmit() async {
    if (!validateStep()) return;

    if (isLastStep) {
      await submitRecord(
        doctorId: "1",
        date: "2026-04-12",
        startTime: "09:30",
        endTime: "09:45",
      );
    } else {
      nextStep();
    }
  }
  List<Widget> reviewData() {
    return [
      Text("الطول: ${height.text}"),
      Text("الوزن: ${weight.text}"),
      Text("زمرة الدم: ${bloodType.text}"),

      Text("الأمراض: ${chronicDiseases.text}"),
      Text("الحساسية: ${allergies.text}"),
      Text("الأدوية: ${medications.text}"),

      Text("مدخن: ${isSmoker ? "نعم" : "لا"}"),
      Text("الضغط: ${bloodPressure.text}"),
      Text("العمليات: ${surgeries.text}"),
      Text("التاريخ العائلي: ${familyHistory.text}"),
    ];
  }
  void setBloodType(String? val) {
    bloodType.text = val ?? "";
    update();
  }

  void toggleSmoking(bool val) {
    isSmoker = val;
    update();
  }
  List<String> bloodTypes = ["A+","A-","B+","B-","O+","O-","AB+","AB-"];

  List<String> chronicOptions = ["سكري", "ضغط", "قلب"];
  List<String> allergyOptions = ["بنسلين", "غبار", "طعام"];
  List<String> medicationOptions = ["انسولين", "مسكنات", "ضغط"];
  @override
  void onInit() {
    chronicDiseases = TextEditingController();
    allergies = TextEditingController();
    medications = TextEditingController();
    notes = TextEditingController();
    height = TextEditingController();
    weight = TextEditingController();
    bloodType = TextEditingController();
    surgeries = TextEditingController();
    familyHistory = TextEditingController();
    bloodPressure = TextEditingController();
    super.onInit();
  }

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      update(); // أو إذا لاحقاً Rx منشيلها
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }
  bool isLoading = false;

  bool validateStep() {
    if (currentStep == 0) {
      if (height.text.isEmpty || weight.text.isEmpty || bloodType.text.isEmpty) {
        Get.snackbar("خطأ", "عبي كل الحقول الأساسية");
        return false;
      }
    }

    if (currentStep == 1) {
      if (chronicDiseases.text.isEmpty &&
          allergies.text.isEmpty &&
          medications.text.isEmpty) {
        Get.snackbar("تنبيه", "يفضل تعبئة الحالة الصحية");
      }
    }

    if (currentStep == 2) {
      if (bloodPressure.text.isEmpty) {
        Get.snackbar("خطأ", "أدخل ضغط الدم");
        return false;
      }
    }

    return true;
  }
  void goToStep(int stepIndex) {
    currentStep = stepIndex; // تعيين الخطوة المستهدفة
    update(); // تحديث الواجهة ليقوم الـ AnimatedSwitcher بتغيير الودجت
  }
  submitRecord({
    required String doctorId,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      isLoading = true;
      update();

      var response = await medicalRecordData.postData(
        chronicDiseases: chronicDiseases.text,
        allergies: allergies.text,
        medications: medications.text,
        notes: notes.text,
        isSmoker: isSmoker ? "1" : "0",
        height: height.text,
        weight: weight.text,
        bloodType: bloodType.text,
        surgeries: surgeries.text,
        familyHistory: familyHistory.text,
        bloodPressure: bloodPressure.text,
        doctorId: doctorId,
        date: date,
        startTime: startTime,
        endTime: endTime,
      );

      isLoading = false;
      update();
      String formatDate(String date) {
        DateTime parsedDate = DateTime.parse(date);
        return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
      }
      String formatTime(String time) {
        return time.substring(0, 5);
      }
      if (response['success'] == true) {
        Future.delayed(Duration(milliseconds: 100), () {
          showCustomDialog(
            title: "تم تأكيد الحجز",
            message:
            "📅 التاريخ: ${formatDate(date)}\n"
                "⏰ من ${formatTime(startTime)} إلى ${formatTime(endTime)}",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            buttonText: "حسنا",
          );
        });
      }else {
        showCustomDialog(
          title: "فشل الحجز",
          message:"لا يوجد مواعيد متاحة حاليا",
          icon: Icons.wifi_tethering_error,
          iconColor: Colors.red,
          buttonText: "حسنا",
        );
      //  Get.snackbar("فشل", "لا يوجد مواعيد متاحة حالياً");
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("خطأ", "حدث خطأ غير متوقع");
    }
  }
}
