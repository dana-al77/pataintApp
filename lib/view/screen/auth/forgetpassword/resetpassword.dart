import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/resetpasswordcontroller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/imageasset.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitlleauth.dart';
import '../../../widget/auth/textsignup.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(resetPasswordControllerImp());
    return Scaffold(
        body: GetBuilder<resetPasswordControllerImp>(builder: (controller) =>
    handlingDataRequest(statusRequest:  controller.statusRequest,
    widget:
    Stack(
      children:[

        Positioned.fill(
          child: Image.asset(
            AppImageAsset.repassword,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned.fill(
          child: Container(
          ),
        ),

        Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                child: Form(
                  key: controller.formstate,
                  child: ListView(children: [
                    SizedBox(height: 200,),
                    CustomTextTitleAuth(text: "26".tr,),
                    SizedBox(height: 10,),
                    CustomTextBodyAuth(text: "27".tr,),
                    SizedBox(height: 65,),

                   Container
                     (
                     padding: const EdgeInsets.all(25),
                     decoration: BoxDecoration(
                       color: AppColor.backgroundColor,
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(
                         color: Colors.blue.shade100.withOpacity(0.5),
                         width: 1.2,
                       ),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
                           blurRadius: 15,
                           offset: const Offset(0, 8),
                         ),
                       ],
                     ),
                     child:Column(
                     children: [ GetBuilder<resetPasswordControllerImp>(builder: (controller) =>
                         CustomTextFormAuth(
                           obscureText: controller.isShowPassword,
                           onTapIcon: (){
                             controller.showPassword();
                           },
                           hindtext: "8".tr,
                           labeltext: "كلمة السر",
                           iconData: Icons.lock_outline,
                           mycontroller: controller.password,
                           valid: (val){
                             return validInput(val!, 5, 80, "password");
                           }, isNumber: false,
                         ),
                     ),

                       GetBuilder<resetPasswordControllerImp>(builder: (controller) => CustomTextFormAuth(
                         obscureText: controller.isShowRePassword,
                         onTapIcon: (){
                           controller.showRePassword();
                         },
                         hindtext: "29".tr,
                         labeltext: "تأكيد كلمة السر",
                         iconData: Icons.lock_outline,
                         mycontroller: controller.repassword,
                         valid: (val){
                           return validInput(val!, 5, 80, "password");
                         }, isNumber: false,
                       ),),

                      SizedBox(height: 20,),

                       CustomButtonAuth(text: "28".tr,onPressed: (){
                         controller.goToSuccessResetPassword();
                       },),
                     ],
                   ) ,)
                  ],),
                ),
              ),
   ] ))
          ,)
    );
  }
}
