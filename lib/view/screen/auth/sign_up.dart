
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/signupcontroller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/valid_input.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitlleauth.dart';
import '../../widget/auth/textsignup.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
      Get.put(SignUpControllerImp());
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColor.white,
        //   //   elevation: 0.0,
        //   title: Text("11".tr ,style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColor.grey,),
        //   ),),
        body:
          WillPopScope(
          onWillPop: alertExitApp,
          child: GetBuilder<SignUpControllerImp>(builder: (controller) =>
    // handlingDataRequest(statusRequest:  controller.statusRequest,
    // widget:
          Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/login.jpg",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned.fill(
          child: Container(
          ),
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                SizedBox(height: 200,),
                CustomTextTitleAuth(text: "مرحب بك,ابدأ رحلة تعافيك معنا",),
                CustomTextBodyAuth(text: "أنشئ حسابك وانطلق نحو صحة مستدامة",),
                SizedBox(height: 40,),
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
                  child:
                  Column(
                    children: [

                      CustomTextFormAuth(
                        hindtext: "13".tr,
                        labeltext: "12".tr,
                        iconData: Icons.person, mycontroller: controller.name,
                        valid: (val){
                          return validInput(val!, 3, 100, "name");
                        }, isNumber: false,
                      ),
                      CustomTextFormAuth(
                        hindtext: "6".tr,
                        labeltext: "5".tr,
                        iconData: Icons.email_outlined,
                        mycontroller: controller.email,
                        valid: (val){
                          return validInput(val!, 5, 100, "email");
                        }, isNumber: false,
                      ),

                      GetBuilder<SignUpControllerImp>(builder: (controller) =>
                          CustomTextFormAuth(
                            obscureText: controller.isShowPassword,
                            onTapIcon: (){
                              controller.showPassword();
                            },
                            hindtext: "8".tr,
                            labeltext: "7".tr,
                            iconData: Icons.lock_outline,
                            mycontroller: controller.password,
                            valid: (val){
                              return validInput(val!, 5, 80, "password");
                            }, isNumber: false,
                          ),
                      ),
                      GetBuilder<SignUpControllerImp>(builder: (controller) =>
                          CustomTextFormAuth(
                            obscureText: controller.isShowRePassword,
                            onTapIcon: (){
                              controller.showRePassword();
                            },
                            hindtext: "8".tr,
                            labeltext: "تأكيد كلمة السر",
                            iconData: Icons.lock_outline,
                            mycontroller: controller.Repassword,
                            valid: (val){
                              return validInput(val!, 5, 80, "password");
                            }, isNumber: false,
                          ),
                      ),
                      // CustomTextFormAuth(
                      //   hindtext: "الجنس",
                      //   labeltext: "الجنس",
                      //   iconData: Icons.add, mycontroller: controller.gender,
                      //   valid: (val){
                      //     return validInput(val!, 3, 100, "name");
                      //   }, isNumber: false,
                      // ),

                      // CustomTextFormAuth(
                      //   hindtext: "الرقم",
                      //   labeltext: "ادخل الرقم",
                      //   iconData: Icons.person, mycontroller: controller.phone,
                      //   valid: (val){
                      //     return validInput(val!, 3, 100, "number");
                      //   }, isNumber: true,
                      // ),
                      const SizedBox(height: 20),
                      CustomButtonAuth(
                        text: "انشاء حساب",
                        onPressed: () => controller.SignUp(),
                      ),
                      ///////////////////////////
                      const SizedBox(height: 28),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "لديك حساب بالفعل؟ ",
                            style: TextStyle(color: AppColor.black, fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              controller.goToLogIn();
                            },
                            child: Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: AppColor.thirdColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ) ],
            ),
          ),
        ),
      ]),



      )

        )
       // )
    );
  }
}
