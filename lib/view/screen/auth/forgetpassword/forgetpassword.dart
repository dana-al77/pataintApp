import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/forgetpasswordcontroller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitlleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(ForgetPasswordControllerImp());
    return Scaffold(

        body:GetBuilder<ForgetPasswordControllerImp>(builder: (controller) =>
    handlingDataRequest(statusRequest:  controller.statusRequest,
   widget:
          Stack(
      children:[
        Positioned.fill(
          child: Image.asset(
            "assets/images/repassword.jpg",
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

                    SizedBox(height: 230,),
                    CustomTextTitleAuth(text: "استعادة كلمة المرور",),
                    CustomTextBodyAuth(text: "يرجى إدخال بريدك الإلكتروني لإرسال تعليمات إعادة التعيين",),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
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
                    child:Column(children: [
                      SizedBox(height: 10,),
                      CustomTextFormAuth(
                        hindtext: "6".tr,
                        labeltext: "5".tr,
                        iconData: Icons.email_outlined,
                        mycontroller: controller.email,
                        valid : (val){
                          return validInput(val!, 5, 100, "email");
                        }, isNumber: false,
                      ),


                      SizedBox(height: 30,),
                      CustomButtonAuth(text: "ارسال",onPressed: (){
                        controller.checkEmail();
                      },),
                    ],)

                  )],
                  ),
                ),
              ),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColor.thirdColor,
              size: 25,
            ),
            onPressed: () {

              controller.goToLogin();
            },
          ),
        ),
   ] ))
         ,)
    );
  }
}
