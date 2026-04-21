import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/resendOtp.dart';
import '../../data/datasource/remote/auth/verfiycode_signup.dart';

abstract class VerfiyCodeSignUpcontroller extends GetxController{
  checkCode();
  goToLogin();
  goToSuccessSignUp(String VerifyCodeSignUp);
}
class   VerfiyCodeSignUpcontrollerImp extends VerfiyCodeSignUpcontroller{
  VerifyCodeSignUpData verifyCodeSignUpData = VerifyCodeSignUpData(Get.find());
  ResendOtpData resendOtpData = ResendOtpData(Get.find());
  String? email;
  StatusRequest statusRequest =StatusRequest.none;
  MyServices myServices = Get.find();

  @override
  checkCode() {

  }
  goToLogin() {
    Get.offNamed(AppRoute.forgetpassword);
  }
  @override
  goToSuccessSignUp(VerifyCodeSignUp) async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifyCodeSignUpData.postData(email!,VerifyCodeSignUp
    );
    print("==============================response $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['message'] == "OTP verified") {
        //////////////////////   5
        String token = response['data']['token'];
        String id = response['data']['user']['id'].toString();
        String name=response['data']['user']['name'];

        myServices.sharedPreferences.setString("token", token);
        myServices.sharedPreferences.setString("id", id);

        myServices.sharedPreferences.setString("name", name);
        myServices.sharedPreferences.setString("step", "5");

       // print("TOKEN SAVED: $token");
        Get.offAllNamed(AppRoute.HomeScreen);
      } else {
        showCustomDialog(
          title: "رمز التحقق غير صحيح!",
          message: "الرجاء التأكد من الرمز وإعادة المحاولة.",
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.red,
        );

    }
    update();

  }}
    resendOtp() async {
      statusRequest = StatusRequest.loading;
      update();

      var response = await resendOtpData.postData(email!);

      print("==============================response $response");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['success'] == true) {
          Get.snackbar(
            "تم الإرسال ✅",
            "تم إعادة إرسال رمز التحقق إلى بريدك الإلكتروني",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        else if(response['error'] == 'Too many attempts, account locked'){
          showCustomDialog(
            title: "تنبيه",
            message: "لقد نفذت محاولاتك حاول بعد قليل",
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.orange,
          );

        }
        else {
          showCustomDialog(
            title: "خطأ",
            message: "حدث خطأ أثناء إعادة الإرسال",
            icon: Icons.error_outline,
            iconColor: Colors.red,
          );
        }
      }

      update();
    }
  @override
  void onInit() {
  // email =Get.arguments['email'];
    email = Get.arguments?['email'] ?? myServices.sharedPreferences.getString("email");
    super.onInit();
  }


}