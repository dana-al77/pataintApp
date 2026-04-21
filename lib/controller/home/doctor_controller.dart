import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/doctor_data.dart';
import '../../data/model/doctor.dart';

abstract class DoctorController extends GetxController {
  getDoctors();
}

class DoctorControllerImp extends DoctorController {
  StatusRequest statusRequest = StatusRequest.none;

  DoctorData doctorData = DoctorData(Get.find());

  List<DoctorModel> data = [];

  @override
  getDoctors() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await doctorData.get();

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        List list = response['data'];
        data.addAll(list.map((e) => DoctorModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    getDoctors();
    super.onInit();
  }
}