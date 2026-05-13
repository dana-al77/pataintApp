import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/routes.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/Support_data.dart';
import '../../data/datasource/remote/medical_tips.dart';
import '../../data/model/medical_tip.dart';
import '../../data/model/support_model.dart';


abstract class servicesController extends GetxController {
  goToFirstAppiont();
  goToUpLoad();
  goToQR();
}

class servicesControllerImp extends servicesController {

  goToFirstAppiont(){
    Get.toNamed(AppRoute.firstAppiont);
  }
  goToUpLoad(){
    Get.toNamed(AppRoute.upLoadMedical);
 }
  goToQR(){
//    Get.to(() => QrHomeView());

    Get.toNamed(AppRoute.medicalQR);
  }







  @override
  void onInit() {
    super.onInit();
  }


// myback(){
//   Get.offAllNamed(AppRoute.Dashboard);
// return Future.value(false);
// }

}
