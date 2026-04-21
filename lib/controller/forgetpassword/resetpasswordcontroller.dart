import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/functions/show_custom_dialog.dart';
import '../../data/datasource/remote/forgetpassword/resetpassword.dart';

abstract class resetPasswordController extends GetxController{
  // resetPasword();
  goToSuccessResetPassword();
}
class resetPasswordControllerImp extends resetPasswordController{
  GlobalKey<FormState> formstate= GlobalKey<FormState>();

  late TextEditingController password ;
  late TextEditingController repassword ;
  String? email;
   ResetPasswordData resetPasswordData=ResetPasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? code;
  bool isShowPassword = false;
  bool isShowRePassword = false;
  showPassword(){
    isShowPassword = isShowPassword == true ?false :true;
    update();
  }


   showRePassword() {
    isShowRePassword = !isShowRePassword;
    update();
  }

  // @override
  // resetPasword() {
  //
  // }

  @override
  goToSuccessResetPassword() async{

   if(password.text != repassword.text)
     {
       return showCustomDialog(
         title: "تحذير",
         message: "كلمة السر غير متطابقة",
         icon: Icons.warning_amber_rounded,
         iconColor: Colors.orange,
       );
     }
    var formData =formstate.currentState;

    if(formData!.validate()){
      statusRequest = StatusRequest.loading;
      update();

      var response = await resetPasswordData.postData(
        email!,
        code!,
        password.text,
        repassword.text,
      );
      print("==============================response $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['message'] == "Password reset successfully"){

          Get.offNamed(AppRoute.login);
        }
           else if(response['error'] == 'You cannot use your old password'){
          showCustomDialog(
            title: "تنبه",
            message: "لا يمكنك استخدام كلمة المررو القديمة",
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red,
          );

        }

        else {
          showCustomDialog(
            title: "خطأ",
            message: "الرمز الذي أدخلته غير صحيح أو انتهت صلاحيته.",
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }else{

      print(" not valid");
    }
   }
  @override
  void onInit() {
    code = Get.arguments['code'];
    email = Get.arguments['email'];
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {

    password.dispose();
    repassword.dispose();
    super.dispose();
  }


}