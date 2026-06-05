import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/appiontement/cancel_appointment_data.dart';
import '../../data/datasource/remote/appiontement/my_appointments_data.dart';
import '../../data/model/my-appiontement.dart';

class MyAppointmentsController extends GetxController {

  StatusRequest statusRequest = StatusRequest.none;

  MyAppointmentsData data = MyAppointmentsData(Get.find());

  CancelAppointmentData cancelData = CancelAppointmentData(Get.find());

  List<MyAppointmentModel> allAppointments = [];

  List<MyAppointmentModel> upcomingAppointments = [];
  List<MyAppointmentModel> completedAppointments = [];
  List<MyAppointmentModel> cancelledAppointments = [];

  MyAppointmentModel? nextAppointment;

  int selectedTab = 0;
  void changeTab(int index) {
    selectedTab = index;
    update(); // لتحديث الواجهة فوراً
  }

// دالة مساعدة لترجيع القائمة الصحيحة بناءً على التبويب المختار
  List<MyAppointmentModel> get currentList {
    if (selectedTab == 0) return upcomingAppointments;
    if (selectedTab == 1) return completedAppointments;
    return cancelledAppointments;
  }

  @override
  void onInit() {
    getAppointments();
    super.onInit();
  }

  Future<void> getAppointments() async {

    statusRequest = StatusRequest.loading;
    update();

    var response = await data.getAppointments();

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {

      if (response['success'] == true) {

        List dataList = response['data'];

        allAppointments = dataList
            .map((e) => MyAppointmentModel.fromJson(e))
            .toList();

        upcomingAppointments = allAppointments
            .where((e) => e.status == "pending")
            .toList();

        completedAppointments = allAppointments
            .where((e) => e.status == "confirmed")
            .toList();

        cancelledAppointments = allAppointments
            .where((e) => e.status == "cancelled")
            .toList();

        if (upcomingAppointments.isNotEmpty) {
          nextAppointment = upcomingAppointments.first;
        }
      }
    }

    update();
  }

  Future<void> cancelAppointment(
      String paymentId,
      int appointmentId,
      ) async {

    var response =
    await cancelData.cancelAppointment(paymentId);

    print("❌ CANCEL RESPONSE: $response");

    // if (response['ErrorCode'] == 0) {
    //
    //   upcomingAppointments.removeWhere(
    //         (e) => e.id == appointmentId,
    //   );
////

      if (response is Map) {
        if (response['ErrorCode'] == 0) {

          upcomingAppointments.removeWhere(
                (e) => e.id == appointmentId,
          );

          update();

          Get.snackbar("تم الإلغاء", "تم إلغاء الحجز بنجاح");

        } else {
          Get.snackbar("خطأ", response['ErrorMessage']);
        }

      } else {
        Get.snackbar("خطأ", "فشل الاتصال بالسيرفر");
      }
      ////

  }
}