import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/Helper.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../core/functions/show_dialoge_booking.dart';
import '../../data/datasource/remote/appiontement/appointement.dart';
import '../../data/datasource/remote/appiontement/booking_data.dart';
import '../../data/datasource/remote/paymera/payment_status.dart';
import '../../data/model/available.dart';
import '../../data/model/booking_model.dart';
import '../../data/model/doctor.dart';
import '../../view/screen/payment/payment_view.dart';

class AppointmentController extends GetxController {
  /// =============================
  /// 🔹 Status
  /// =============================
  StatusRequest statusRequest = StatusRequest.none;

  /// =============================
  /// 🔹 Data sources
  /// =============================
  final AppointmentData appointmentData = AppointmentData(Get.find());
  final BookingData bookingData = BookingData(Get.find());
  PaymentStatusData paymentStatusData = PaymentStatusData(Get.find());

  String? paymentId;
  /// =============================
  /// 🔹 Models
  /// =============================
  AvailableSlotsModel? slotsModel;
  BookingModel? bookingModel;
  DoctorModel? doctorModel;
  /// =============================
  /// 🔹 UI State
  /// =============================
  int? selectedIndex;
  String? selectedDate;
  String? selectedMonth;
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

  Future<void> startPaymentPolling() async {
    if (paymentId == null) return;

    int attempts = 0;

    while (attempts < 20) {
      await Future.delayed(Duration(seconds: 5));

      var response = await paymentStatusData.getStatus(paymentId!);

      print("💰 STATUS: $response");

      if (response is StatusRequest) {
        attempts++;
        continue;
      }

      if (response['success'] == true) {

        String status = response['data']['status'];
        String amount = response['data']['amount'].toString();

        if (status == "A") {

          Get.back();

          showCustomDialog(
            title: "تم الدفع بنجاح",
            message:
            "✅ الحالة: ${paymentStatusText(status)}\n"
                "💳 المبلغ المدفوع: $amount ل.س",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            buttonText: "حسناً",
          );

          return;
        }

        if (status == "F") {

          Get.back();

          showCustomDialog(
            title: "فشل الدفع",
            message: "❌ فشلت عملية الدفع",
            icon: Icons.error,
            iconColor: Colors.red,
            buttonText: "حسناً",
          );

          return;
        }
      }

      attempts++;
    }

    Get.snackbar("تنبيه", "انتهت مهلة التحقق");
  }

  /// =============================
  /// 🔹 Get Available Slots
  /// =============================
  Future<void> getSlots(int doctorId, String date) async {
    statusRequest = StatusRequest.loading;
    update();

    final response =
    await appointmentData.getAvailableSlots(doctorId, date);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['success'] == true) {
      slotsModel = AvailableSlotsModel.fromJson(response['data']);
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  /// =============================
  /// 🔹 Select Date
  /// =============================
  void selectDate(int doctorId, String date) {
    selectedDate = date;
    selectedIndex = null;
    getSlots(doctorId, date);
  }
  void selectMonth(String month) {
    selectedMonth = month;
    selectedDate = null;
    selectedIndex = null;
    update();
  }
  /// =============================
  /// 🔹 Select Time
  /// =============================
  void selectTime(int index) {
    selectedIndex = index;
    update();
  }

  /// =============================
  /// /// 🔥 pay Appointment
  //   /// =============================
  Future<void> openPaymentUrl(String url) async {
    Get.to(() => PaymentWebView(
      url: url,
      paymentId: paymentId!,
      onFinish: () {
        startPaymentPolling();
      },
    ));
  }
  /// =============================
  /// 🔥 Book Appointment
  /// =============================
  Future<void> bookAppointment(int doctorId) async {
    if (selectedDate == null || selectedIndex == null) {
      Get.snackbar("تنبيه", "يرجى اختيار التاريخ والوقت");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final slot = slotsModel!.slots![selectedIndex!];

    final response = await bookingData.bookAppointment(
      doctorId: doctorId,
      date: selectedDate!,
      startTime: slot.startTime!,
      amount: "20000",
    );

    print("🔥 FULL RESPONSE: $response");
    print("📌 TYPE OF RESPONSE: ${response.runtimeType}");

    statusRequest = handlingData(response);

    if (statusRequest != StatusRequest.success) {
      print("❌ REQUEST FAILED");
      Get.snackbar("خطأ", "مشكلة في الاتصال");
      update();
      return;
    }

    /// 🔥 هون الاستدعاء
    String message = ApiHelper.getMessage(response);

    print("📌 FINAL MESSAGE: $message");

    /// ✅ نجاح
    if (response['success'] == true) {
      bookingModel = BookingModel.fromJson(response['data']);
      final paymentUrl = response['data']['payment_url'];
      paymentId = response['data']['payment_id'];

      final appointment = response['data']['appointment'];

      final date = appointment['date'];
      final startTime = appointment['start_time'];
      final endTime = appointment['end_time'];

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
      // showBookingSuccessDialog(
      //   doctorName: doctorModel?.name ?? "غير معروف",
      //   date: selectedDate!,
      //   time: slot.startTime!,
      // );

      selectedIndex = null;
    }

    /// ❌ فشل
    else {

      if (response['status'] == 401) {
        showCustomDialog(
            title: "تنبيه",
            message: message,
            icon: Icons.warning_rounded,
            buttonText: "حسنا",
            iconColor: Colors.orange);
        // Get.defaultDialog(
        //   title: "تنبيه",
        //   middleText: message,
        //   textConfirm: "حسناً",
        //   onConfirm: () => Get.back(),
        // );
      } else {
        Get.snackbar("خطأ", message);
      }
    }

    update();
  }
}
