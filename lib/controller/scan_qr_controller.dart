import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../data/datasource/remote/scan_qr_data.dart';

class ScanQrController extends GetxController {

  StatusRequest statusRequest =
      StatusRequest.none;

  ScanQrData data =
  ScanQrData(Get.find());

  Map? medicalRecord;

  getRecord() async {

    statusRequest =
        StatusRequest.loading;

    update();

    String url = Get.arguments;

    var response =
    await data.getMedicalRecord(url);

    print(response);

    statusRequest =
        handlingData(response);

    if (response['success'] == true) {

      medicalRecord =
      response['data'];

    } else {

      statusRequest =
          StatusRequest.failure;
    }

    update();
  }

  @override
  void onInit() {

    getRecord();

    super.onInit();
  }
}