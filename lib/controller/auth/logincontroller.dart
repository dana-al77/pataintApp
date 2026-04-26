
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../core/services/fcm_service.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/login.dart';

abstract class LogginController extends GetxController{
  login();
  goToSignUp();
  goToForgetPassword();
}
class LoginControllerImp extends LogginController{
  GlobalKey<FormState> formstate= GlobalKey<FormState>();
  late TextEditingController email ;
  late TextEditingController password ;

  bool isShowPassword = false;
  MyServices myServices=Get.find();
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest =StatusRequest.none;

  showPassword(){
    isShowPassword = isShowPassword == true ?false :true;
    update();
  }

  @override
  login() async{
    var formData = formstate.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      String? fcmToken = await FCMService.getToken();

      var response = await loginData.postData(
        email.text,
        password.text,
        fcmToken, // 👈 أضفناه


      );
      print("==============================response $response");
      statusRequest = handlingData(response);
     if (StatusRequest.success == statusRequest) {

         if (response['success'] == true) {
          //  myServices.sharedPreferences.setString("id", response["data"]["id"].toString());
          //  //////////////////اشعار
          //  String userid = myServices.sharedPreferences.getString("id")!;
          //  /////////////
          // myServices.sharedPreferences.setString("name", response["data"]["full_name"]);
          //  myServices.sharedPreferences.setString("email", response["data"]["email"]);
          // myServices.sharedPreferences.setString("password", response["data"]["user"]["password"]);
          //  myServices.sharedPreferences.setString("token", response["data"]["token"]);
           myServices.sharedPreferences.setString("step", "4");
           myServices.sharedPreferences.setString("email", email.text);
////////////
          // FirebaseMessaging.instance.subscribeToTopic("users");
         // FirebaseMessaging.instance.subscribeToTopic("users${userid}");
////////////
           Get.toNamed(
                 AppRoute.verfiycode,arguments: {
               "email" : email.text
             }
           );
              }
        //
         else {
           showCustomDialog(
             title: "خطأ في الدخول",
             message: "البريد الإلكتروني أو كلمة المرور التي أدخلتها غير صحيحة.ً",
             icon: Icons.warning_amber_rounded,
             iconColor: Colors.orange,
           );
          statusRequest = StatusRequest.failure;

        }
      }
     // else if(response['success'] == false) {
     //   showCustomDialog(
     //     title: "خطأ في الدخول",
     //     message: "البريد الإلكتروني أو كلمة المرور التي أدخلتها غير صحيحة.ً",
     //     icon: Icons.warning_amber_rounded,
     //     iconColor: Colors.orange,
     //   );
     //   //   statusRequest = StatusRequest.failure;
     //
     // }
      update();
    } else {
      print(" not valid");
    }
  }

  @override
  goToSignUp() {
  Get.offNamed(AppRoute.signup);
  }

  @override
  goToForgetPassword() {
 Get.toNamed(AppRoute.forgetpassword);
  }
@override
  void onInit() {
    // FirebaseMessaging.instance.getToken().then((value){
    //   print("🔥 Firebase token: $value");
    //  String? token = value ;
    // });
    email =TextEditingController();
    password =TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }


}