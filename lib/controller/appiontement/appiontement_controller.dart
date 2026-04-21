import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/Helper.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../core/functions/show_dialoge_booking.dart';
import '../../data/datasource/remote/appiontement/appointement.dart';
import '../../data/datasource/remote/appiontement/booking_data.dart';
import '../../data/model/available.dart';
import '../../data/model/booking_model.dart';
import '../../data/model/doctor.dart';

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

  /// =============================
  /// 🔹 Select Time
  /// =============================
  void selectTime(int index) {
    selectedIndex = index;
    update();
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

      showBookingSuccessDialog(
        doctorName: doctorModel?.name ?? "غير معروف",
        date: selectedDate!,
        time: slot.startTime!,
      );

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
