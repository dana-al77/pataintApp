
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/signup.dart';

abstract class SignUpController extends GetxController {
  SignUp();
  goToLogIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController Repassword;

   StatusRequest statusRequest=StatusRequest.none;
  MyServices myServices=Get.find();

  SignupData signuptData = SignupData(Get.find());

  List data = [];

  bool isShowPassword = false;
  bool isShowRePassword = false;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }
  showRePassword() {
    isShowRePassword = !isShowRePassword;
    update();
  }
  @override
  @override
  SignUp() async {
    if (password.text != Repassword.text) {
      return showCustomDialog(
        title: "تحذير",
        message: "كلمة السر غير متطابقة",
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange,
      );
    }

    var formData = formstate.currentState;

    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await signuptData.postData(
        name.text,
        email.text,
        password.text,
        Repassword.text,
        "patient",
      );

      print("==============================response $response");

      statusRequest = handlingData(response);

      /// ✅ أهم تعديل هون
      if (StatusRequest.success == statusRequest) {

        /// 🔴 إذا في errors من السيرفر
        if (response['errors'] != null) {
          String errorMessage = "حدث خطأ";

          if (response['errors']['email'] != null) {
            errorMessage = response['errors']['email'][0];
          } else if (response['message'] != null) {
            errorMessage = response['message'];
          }

          showCustomDialog(
            title: "خطأ",
            message: "الايميل موجود مسبقا",
            icon: Icons.error_outline,
            iconColor: Colors.red,
          );

          return;
        }
}
      if (StatusRequest.success == statusRequest) {
        if (response['message'] == "Registered successfully") {
          myServices.sharedPreferences
              .setString("token", response["data"]["token"]);
          myServices.sharedPreferences.setString("step", "2");

          Get.toNamed(AppRoute.completeProfile);

          print("valid");
        }
      }

      update();
    } else {
      print("not valid");
    }
  }

  @override
  goToLogIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    Repassword= TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    Repassword.dispose();
    super.dispose();
  }
}
