import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/datasource/remote/appiontement/firstly_appiontement.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../data/datasource/remote/paymera/payment_status.dart';
import '../../view/screen/payment/payment_view.dart';




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
  late TextEditingController maritalStatus;
  late TextEditingController numberOfChildren;
  late TextEditingController amount;
  StatusRequest statusRequest = StatusRequest.none;

  FistAppiontData medicalRecordData = FistAppiontData(Get.find());
  PaymentStatusData paymentStatusData = PaymentStatusData(Get.find());
  String? qrCodeUrl;
  String? qrCodePath;
  String? paymentId;
  bool isSmoker = false;
  bool get isLastStep => currentStep == 3;
  bool isStepCurrent(int index) => currentStep == index;
  bool isStepDone(int index) => currentStep > index;
  // void handleNextOrSubmit() async {
  //   if (!validateStep()) return;
  //
  //   if (isLastStep) {
  //     await submitRecord(
  //       doctorId: "1",
  //       date: "2026-05-05",
  //       startTime: "10:00",
  //       endTime: "10:15",
  //     );
  //   } else {
  //     nextStep();
  //   }
  // }
  void handleNextOrSubmit() async {
    if (!validateStep()) return;

    if (isLastStep) {
      await submitRecord();
    } else {
      nextStep();
    }
  }
  // Future<void> openPaymentUrl(String url) async {
  //   final Uri uri = Uri.parse(url);
  //
  //   if (!await launchUrl(
  //     uri,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     Get.snackbar("خطأ", "تعذر فتح صفحة الدفع");
  //   }
  // }
  Future<void> openPaymentUrl(String url) async {
    Get.to(() => PaymentWebView(
      url: url,
      paymentId: paymentId!,
      onFinish: () {
        startPaymentPolling();
      },
    ));
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

  List<String> chronicOptions = [
    "سكري",
    "ضغط الدم",
    "أمراض القلب",
    "الربو",
    "أمراض الكلى",
    "أمراض الكبد",
    "الغدة الدرقية",
    "أخرى",
  ];

  List<String> allergyOptions = [
    "البنسلين",
    "الأسبرين",
    "الغبار",
    "حبوب اللقاح",
    "الحليب",
    "البيض",
    "أخرى",
  ];
  List<String> medicationOptions = [
    "الأنسولين",
    "الضغط",
    "القلب",
    "الربو",
    "الغدة الدرقية",
    "مميعات الدم",
    "مكملات غذائية",

  ];
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
    maritalStatus = TextEditingController();
    numberOfChildren = TextEditingController();
    amount = TextEditingController();
    super.onInit();

  }
  String paymentStatusText(String status) {
    switch (status) {
      case "A":
        return "تم قبول الدفع";
      case "P":
        return "قيد المعالجة";
      case "F":
        return "فشل الدفع";
      default:
        return "حالة غير معروفة";
    }
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
    if (currentStep == 3) {
      if (amount.text.isEmpty) {
        Get.snackbar("خطأ", "أدخل مبلغ الدفع");
        return false;
      }
    }
    return true;
  }
  void goToStep(int stepIndex) {
    currentStep = stepIndex; // تعيين الخطوة المستهدفة
    update(); // تحديث الواجهة ليقوم الـ AnimatedSwitcher بتغيير الودجت
  }
  Future<void> startPaymentPolling() async {
    if (paymentId == null) return;

    int attempts = 0;

    while (attempts < 20) {
      await Future.delayed(Duration(seconds: 5));

      var response = await paymentStatusData.getStatus(paymentId!);

      print("💰 STATUS: $response");

      // 🔥 مهم جداً
      if (response is StatusRequest) {
        print("❌ API ERROR");
        attempts++;
        continue;
      }

      if (response['success'] == true) {
        String status = response['data']['status'];
        String amount = response['data']['amount'].toString();

        String statusText = paymentStatusText(status);

        if (status == "A") {
          // 👇 سكر صفحة الدفع
          Get.back();
          showCustomDialog(
            title: "تم تأكيد الدفع",
            message:
            "✅ الحالة: $statusText\n"
                "💳 المبلغ المدفوع: $amount ل.س",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            buttonText: "حسنا",
          );

          return;
        }

        if (status == "F") {
          Get.back();
          showCustomDialog(
            title: "فشل الدفع",
            message:
            "❌ الحالة: ${paymentStatusText(status)}",
            icon: Icons.error,
            iconColor: Colors.red,
            buttonText: "حسنا",
          );
          return;
        }
      }

      attempts++;
    }

    Get.snackbar("تنبيه", "انتهت مهلة التحقق من الدفع");
  }


  submitRecord() async {
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
        // doctorId: doctorId,
        // date: date,
        // startTime: startTime,
        // endTime: endTime,
        amount: amount.text,
        maritalStatus: maritalStatus.text,
        numberOfChildren: numberOfChildren.text,
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
        final paymentUrl = response['data']['payment_url'];
         paymentId = response['data']['payment_id'];

        // 👇 خزّنه
        this.paymentId = paymentId;
        // 👇 بيانات الموعد
        final appointment = response['data']['appointment'];
        qrCodeUrl = response['data']['qr_code_url'];
        qrCodePath =
        response['data']['medical_record']['qr_code_path'];
        this.qrCodeUrl = qrCodeUrl;
        final date = appointment['date'];
        final startTime = appointment['start_time'];
        final endTime = appointment['end_time'];

        // showCustomDialog(
        //   title: "تم الحجز",
        //   message: "يرجى إتمام الدفع لتأكيد الموعد",
        //   icon: Icons.payment,
        //   iconColor: Colors.orange,
        //   buttonText: "الدفع الآن",
        //   onPressed: () async {
        //     await openPaymentUrl(paymentUrl);
        //
        //     // 👇 بعد الرجوع نتحقق
        //     startPaymentPolling();
        //   },
        //
        // );
        showCustomDialog(
          title: "تم الحجز",
          message:
          "📅 التاريخ: $date\n"
              "⏰ الوقت: من $startTime إلى $endTime\n\n"
              "يرجى إتمام الدفع لتأكيد الموعد",
          icon: Icons.payment,
          iconColor: Colors.orange,
          buttonText: "الدفع الآن",
          onPressed: () async {
            await openPaymentUrl(paymentUrl);
            startPaymentPolling();
          },
        );
      } else {
        // 👇 نحدد الرسالة الصح
        String errorMessage = "";

        if (response['error'] != null && response['error'].toString().isNotEmpty) {
          errorMessage = response['error'];
        } else if (response['message'] != null &&
            response['message'].toString().isNotEmpty) {
          errorMessage = response['message'].toString();
        } else {
          errorMessage = "حدث خطأ غير معروف";
        }

        showCustomDialog(
          title: "فشل الحجز",
          message: errorMessage,
          icon: Icons.error,
          iconColor: Colors.red,
          buttonText: "حسنا",
        );
      }
      print("🔥 RESPONSE: $response");
      // if (response['success'] == true) {
      //   final paymentUrl = response['data']['payment_url'];
      //
      //   showCustomDialog(
      //     title: "تم الحجز",
      //     message: "يرجى إتمام الدفع لتأكيد الموعد",
      //     icon: Icons.payment,
      //     iconColor: Colors.orange,
      //     buttonText: "الدفع الآن",
      //     onPressed: () {
      //       openPaymentUrl(paymentUrl);
      //     },
      //   );
      // }
      // else {
      //   showCustomDialog(
      //     title: "فشل الحجز",
      //     message:"لا يوجد مواعيد متاحة حاليا",
      //     icon: Icons.wifi_tethering_error,
      //     iconColor: Colors.red,
      //     buttonText: "حسنا",
      //   );
      // //  Get.snackbar("فشل", "لا يوجد مواعيد متاحة حالياً");
      // }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("خطأ", "حدث خطأ غير متوقع");
    }
  }
}
