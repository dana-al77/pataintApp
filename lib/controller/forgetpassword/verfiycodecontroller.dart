import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/forgetpassword/verifycode_password.dart';

abstract class VerfiyCodePasscontroller extends GetxController{

  goToresetPassword(String VerifyCode);
  goToLogin();
}
class VerfiyCodePasscontrollerImp extends VerfiyCodePasscontroller{
  String? email;

  StatusRequest statusRequest =StatusRequest.none;

  goToLogin() {
    Get.back();
  }
  @override
  goToresetPassword(VerifyCode) {
    Get.toNamed(
      AppRoute.resetpassword,
      arguments: {
        "email": email,
        "code": VerifyCode,
      },
    );
  }
  @override
  void onInit() {

    email =Get.arguments['email'];
    super.onInit();
  }


}