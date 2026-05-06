import 'dart:ui';
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

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(resetPasswordControllerImp());

    return Scaffold(
      body: GetBuilder<resetPasswordControllerImp>(
        builder: (controller) => handlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Stack(
            children: [

              /// 🌌 الخلفية (نفس اللوجن)
              Positioned.fill(
                child: Image.asset(
                  AppImageAsset.DNABackGround2,
                  fit: BoxFit.cover,
                ),
              ),

              /// 📦 المحتوى
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        /// 🧬 اللوجو
                        Column(
                          children: [
                            Image.asset(
                              AppImageAsset.repassword,
                              height: 140,
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     children: [
                            //       TextSpan(
                            //         text: "Pioneers",
                            //         style: TextStyle(
                            //           color: AppColor.secondyColor,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //       TextSpan(
                            //         text: "Clinic",
                            //         style: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   style: const TextStyle(fontSize: 26),
                            // ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// 🧊 Glass Container
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),

                                /// 🎨 Gradient
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.25),
                                    Colors.white.withOpacity(0.3),
                                  ],
                                ),

                                /// ✨ Border
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1,
                                ),

                                /// 🌫️ Shadow
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),

                              child: Form(
                                key: controller.formstate,
                                child: Column(
                                  children: [

                                    /// 📝 العناوين
                                    CustomTextTitleAuth(text: "تعيين كلمة مرور جديدة"),
                                    CustomTextBodyAuth(
                                        text: "أدخل كلمة مرور جديدة وتأكيدها"),

                                    const SizedBox(height: 25),

                                    /// 🔐 Password
                                    GetBuilder<resetPasswordControllerImp>(
                                      builder: (_) => CustomTextFormAuth(
                                        obscureText: controller.isShowPassword,
                                        onTapIcon: () =>
                                            controller.showPassword(),
                                        hindtext: "اكتب كلمة السر",
                                        labeltext: "كلمة السر",
                                        iconData: Icons.lock_outline,
                                        mycontroller: controller.password,
                                        valid: (val) =>
                                            validInput(val!, 5, 80, "password"),
                                        isNumber: false,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    /// 🔐 Confirm Password
                                    GetBuilder<resetPasswordControllerImp>(
                                      builder: (_) => CustomTextFormAuth(
                                        obscureText:
                                        controller.isShowRePassword,
                                        onTapIcon: () =>
                                            controller.showRePassword(),
                                        hindtext: "تأكيد كلمة السر",
                                        labeltext: "تأكيد كلمة السر",
                                        iconData: Icons.lock_outline,
                                        mycontroller: controller.repassword,
                                        valid: (val) =>
                                            validInput(val!, 5, 80, "password"),
                                        isNumber: false,
                                      ),
                                    ),

                                    const SizedBox(height: 25),

                                    /// 🔘 زر الحفظ
                                    CustomButtonAuth(
                                      text: "حفظ كلمة المرور",
                                      onPressed: () {
                                        controller.goToSuccessResetPassword();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔙 زر الرجوع
              // Positioned(
              //   top: 40,
              //   left: 20,
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.arrow_back_ios_new,
              //       color: AppColor.secondyColor,
              //     ),
              //     onPressed: () {
              //       Get.back();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controller/forgetpassword/resetpasswordcontroller.dart';
// import '../../../../core/class/handling_data_view.dart';
// import '../../../../core/constant/color.dart';
// import '../../../../core/constant/imageasset.dart';
// import '../../../../core/functions/valid_input.dart';
// import '../../../widget/auth/custombuttonauth.dart';
// import '../../../widget/auth/customtextbodyauth.dart';
// import '../../../widget/auth/customtextformauth.dart';
// import '../../../widget/auth/customtexttitlleauth.dart';
// import '../../../widget/auth/textsignup.dart';
//
// class Resetpassword extends StatelessWidget {
//   const Resetpassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//   Get.put(resetPasswordControllerImp());
//     return Scaffold(
//         body: GetBuilder<resetPasswordControllerImp>(builder: (controller) =>
//     handlingDataRequest(statusRequest:  controller.statusRequest,
//     widget:
//     Stack(
//       children:[
//
//         Positioned.fill(
//           child: Image.asset(
//             AppImageAsset.repassword,
//             fit: BoxFit.cover,
//             alignment: Alignment.center,
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//           ),
//         ),
//
//         Container(
//                 padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
//                 child: Form(
//                   key: controller.formstate,
//                   child: ListView(children: [
//                     SizedBox(height: 200,),
//                     CustomTextTitleAuth(text: "26".tr,),
//                     SizedBox(height: 10,),
//                     CustomTextBodyAuth(text: "27".tr,),
//                     SizedBox(height: 65,),
//
//                    Container
//                      (
//                      padding: const EdgeInsets.all(25),
//                      decoration: BoxDecoration(
//                        color: AppColor.backgroundColor,
//                        borderRadius: BorderRadius.circular(20),
//                        border: Border.all(
//                          color: Colors.blue.shade100.withOpacity(0.5),
//                          width: 1.2,
//                        ),
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
//                            blurRadius: 15,
//                            offset: const Offset(0, 8),
//                          ),
//                        ],
//                      ),
//                      child:Column(
//                      children: [ GetBuilder<resetPasswordControllerImp>(builder: (controller) =>
//                          CustomTextFormAuth(
//                            obscureText: controller.isShowPassword,
//                            onTapIcon: (){
//                              controller.showPassword();
//                            },
//                            hindtext: "8".tr,
//                            labeltext: "كلمة السر",
//                            iconData: Icons.lock_outline,
//                            mycontroller: controller.password,
//                            valid: (val){
//                              return validInput(val!, 5, 80, "password");
//                            }, isNumber: false,
//                          ),
//                      ),
//
//                        GetBuilder<resetPasswordControllerImp>(builder: (controller) => CustomTextFormAuth(
//                          obscureText: controller.isShowRePassword,
//                          onTapIcon: (){
//                            controller.showRePassword();
//                          },
//                          hindtext: "29".tr,
//                          labeltext: "تأكيد كلمة السر",
//                          iconData: Icons.lock_outline,
//                          mycontroller: controller.repassword,
//                          valid: (val){
//                            return validInput(val!, 5, 80, "password");
//                          }, isNumber: false,
//                        ),),
//
//                       SizedBox(height: 20,),
//
//                        CustomButtonAuth(text: "28".tr,onPressed: (){
//                          controller.goToSuccessResetPassword();
//                        },),
//                      ],
//                    ) ,)
//                   ],),
//                 ),
//               ),
//    ] ))
//           ,)
//     );
//   }
// }
