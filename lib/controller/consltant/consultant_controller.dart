import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';

import '../../data/datasource/remote/consultant/consultant_data.dart';
import '../../data/datasource/remote/consultant/consultation_payment_data.dart';
import '../../data/datasource/remote/consultant/consultation_payment_status.dart';
import '../../data/datasource/remote/consultant/whats_app_data.dart';

import '../../data/model/consultant/consultant_model.dart';
import '../../view/screen/payment/payment_view.dart';

class ConsultantController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;

  ConsultantData consultantData = ConsultantData(Get.find());
  ConsultationPaymentData paymentData = ConsultationPaymentData(Get.find());
  ConsultationPaymentStatusData paymentStatusData =
  ConsultationPaymentStatusData(Get.find());
  WhatsappData whatsappData = WhatsappData(Get.find());

  List<ConsultantModel> consultants = [];

  String? paymentId;
  int? consultationId;

  @override
  void onInit() {
    getConsultants();
    super.onInit();
  }

  // =========================
  // GET CONSULTANTS
  // =========================
  Future<void> getConsultants() async {
    print("🟡 GET CONSULTANTS START");

    statusRequest = StatusRequest.loading;
    update();

    var response = await consultantData.getConsultants();

    print("🟡 CONSULTANTS RESPONSE: $response");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      consultants.clear();

      List data = response['data'];

      consultants.addAll(
        data.map((e) => ConsultantModel.fromJson(e)),
      );

      print("🟢 CONSULTANTS LOADED: ${consultants.length}");
    }

    update();
  }

  // =========================
  // CREATE PAYMENT
  // =========================
  Future<void> createPayment(ConsultantModel consultant) async {
    print("🟡 CREATE PAYMENT START");

    var response = await paymentData.createPayment(consultant.id!);

    print("🟡 PAYMENT RESPONSE: $response");

    if (response['payment_url'] != null) {
      paymentId = response['payment_id'];
      consultationId = response['consultation_id'];

      print("🟢 paymentId = $paymentId");
      print("🟢 consultationId = $consultationId");

      Get.to(
            () => PaymentWebView(
          url: response['payment_url'],
          paymentId: paymentId!,
          onFinish: () {
            startPaymentPolling(consultant);
          },
        ),
      );
    } else {
      print("🔴 PAYMENT URL NULL");
    }
  }

  // =========================
  // PAYMENT POLLING
  // =========================
  Future<void> startPaymentPolling(ConsultantModel consultant) async {
    if (paymentId == null) {
      print("🔴 paymentId is NULL");
      return;
    }

    int attempts = 0;

    while (attempts < 20) {
      print("⏳ PAYMENT CHECK attempt = $attempts");

      await Future.delayed(const Duration(seconds: 5));

      var response =
      await paymentStatusData.getStatus(paymentId!);

      print("🟣 PAYMENT STATUS RAW RESPONSE: $response");

      if (response is StatusRequest) {
        attempts++;
        continue;
      }

      String status = response['status'];

      print("🟣 PAYMENT STATUS = $status");
      print("🟣 consultationId = $consultationId");

      // =========================
      // SUCCESS
      // =========================
      if (status == "A") {
        print("🟢 PAYMENT SUCCESS BLOCK ENTERED");

        int whatsappAttempts = 0;

        while (whatsappAttempts < 5) {
          print("⏳ WHATSAPP CHECK attempt = $whatsappAttempts");

          if (consultationId == null) {
            print("🔴 consultationId IS NULL");
            return;
          }

          var res =
          await whatsappData.getWhatsappUrl(consultationId!);

          print("🔵 WHATSAPP RESPONSE: $res");

          if (res is StatusRequest) {
            whatsappAttempts++;
            await Future.delayed(const Duration(seconds: 2));
            continue;
          }

          if (res['whatsapp_url'] != null) {
            print("🟢 WHATSAPP READY -> OPENING");

            await openWhatsapp(consultationId!);
            return;
          }

          print("🟠 WHATSAPP NOT READY YET");

          whatsappAttempts++;
          await Future.delayed(const Duration(seconds: 2));
        }

        Get.snackbar(
          "انتظار",
          "الاستشارة غير جاهزة بعد",
        );

        return;
      }

      // =========================
      // FAILED
      // =========================
      if (status == "F") {
        print("🔴 PAYMENT FAILED");

        Get.snackbar(
          "خطأ",
          "فشلت عملية الدفع",
        );

        return;
      }

      attempts++;
    }
  }

  // =========================
  // OPEN WHATSAPP
  // =========================
  Future<void> openWhatsapp(int consultationId) async {
    print("🟡 OPEN WHATSAPP API CALL");

    var response =
    await whatsappData.getWhatsappUrl(consultationId);

    print("🔵 FINAL WHATSAPP RESPONSE: $response");

    if (response is StatusRequest) {
      Get.snackbar(
        "خطأ",
        "حاول لاحقاً",
      );
      return;
    }

    if (response['whatsapp_url'] != null) {
      String url = response['whatsapp_url'];

      print("🟢 LAUNCHING: $url");

      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      print("🔴 WHATSAPP URL NULL");
    }
  }
}