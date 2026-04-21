
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../data/datasource/remote/forgetpassword/check_email.dart';

abstract class ForgetPasswordController extends GetxController{
  checkEmail();
  goToLogin();
}
class ForgetPasswordControllerImp extends ForgetPasswordController{
  CheckEmailData checkEmailData=CheckEmailData(Get.find());
  GlobalKey<FormState> formstate= GlobalKey<FormState>();
  StatusRequest statusRequest =StatusRequest.none;

  late TextEditingController email ;


  @override
  checkEmail() async{
if(formstate.currentState!.validate()){
  statusRequest = StatusRequest.loading;
  update();
  var response = await checkEmailData.postData(
    email.text,



  );
  print("==============================response $response");
  statusRequest = handlingData(response);
  if (StatusRequest.success == statusRequest) {
    if (response['message'] == "OTP sent for password reset") {
      Get.offNamed(AppRoute.verfiycodeforpass, arguments: {
        "email": email.text
      });
    } else {
      showCustomDialog(
        title: "خطأ",
        message: 'الإيميل غير صالح',
        icon: Icons.wifi_tethering_error,
        iconColor: Colors.red,
      );
    }
  }

// 👇 حالة validation (422)
  else if (statusRequest == StatusRequest.failure) {

    // showCustomDialog(
    //   title: "خطأ",
    //   message: response['message'] ?? 'الإيميل غير صالح',
    //   icon: Icons.wifi_tethering_error,
    //   iconColor: Colors.red,
    // );
  }
  update();

}
  }
// داخل الكلاس ForgetPasswordControllerImp
  goToLogin() {
    Get.back();
  }

  @override
  void onInit() {
   email =TextEditingController();

    super.onInit();
  }
  @override
  void dispose() {

    email.dispose();

    super.dispose();
  }


}