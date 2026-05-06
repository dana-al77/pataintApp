import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/forgetpassword/forgetpasswordcontroller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/imageasset.dart';
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
      body: GetBuilder<ForgetPasswordControllerImp>(
        builder: (controller) => handlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Stack(
            children: [

              /// 🌌 الخلفية
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
                            SizedBox(
                              height: 140,
                              width: 140,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [

                                  /// 🧊 الزجاج (الخلف)
                                  ClipOval(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.15),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// 🧬 اللوجو (فوق)
                                  Image.asset(
                                    AppImageAsset.forgetPass,
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            )
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

                                /// Gradient زجاجي
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.25),
                                    Colors.white.withOpacity(0.3),
                                  ],
                                ),

                                /// Border
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1,
                                ),

                                /// Shadow خفيف
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
                                    CustomTextTitleAuth(
                                        text: "استعادة كلمة المرور"),
                                    CustomTextBodyAuth(
                                        text:
                                        "أدخل بريدك الإلكتروني لإرسال رابط إعادة التعيين"),

                                    const SizedBox(height: 25),

                                    /// 📧 Email
                                    CustomTextFormAuth(
                                      hindtext: "اكتب البريد الالكتروني",
                                      labeltext: "البريد الالكتروني",
                                      iconData: Icons.email_outlined,
                                      mycontroller: controller.email,
                                      valid: (val) =>
                                          validInput(val!, 5, 100, "email"),
                                      isNumber: false,
                                    ),

                                    const SizedBox(height: 25),

                                    /// 🔘 زر الإرسال
                                    CustomButtonAuth(
                                      text: "ارسال",
                                      onPressed: () {
                                        controller.checkEmail();
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
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.secondyColor,
                  ),
                  onPressed: () {
                    controller.goToLogin();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controller/forgetpassword/forgetpasswordcontroller.dart';
// import '../../../../core/class/handling_data_view.dart';
// import '../../../../core/constant/color.dart';
// import '../../../../core/constant/imageasset.dart';
// import '../../../../core/functions/valid_input.dart';
// import '../../../widget/auth/custombuttonauth.dart';
// import '../../../widget/auth/customtextbodyauth.dart';
// import '../../../widget/auth/customtextformauth.dart';
// import '../../../widget/auth/customtexttitlleauth.dart';
//
// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//    Get.put(ForgetPasswordControllerImp());
//     return Scaffold(
//
//         body:GetBuilder<ForgetPasswordControllerImp>(builder: (controller) =>
//     handlingDataRequest(statusRequest:  controller.statusRequest,
//    widget:
//           Stack(
//       children:[
//         Positioned.fill(
//           child: Image.asset(
//             AppImageAsset.DNABackGround2,
//             fit: BoxFit.cover,
//
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
//
//                     SizedBox(height: 230,),
//                     CustomTextTitleAuth(text: "استعادة كلمة المرور",),
//                     CustomTextBodyAuth(text: "يرجى إدخال بريدك الإلكتروني لإرسال تعليمات إعادة التعيين",),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(25),
//                     decoration: BoxDecoration(
//                       color: AppColor.backgroundColor,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Colors.blue.shade100.withOpacity(0.5),
//                         width: 1.2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
//                           blurRadius: 15,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child:Column(children: [
//                       SizedBox(height: 10,),
//                       CustomTextFormAuth(
//                         hindtext: "6".tr,
//                         labeltext: "5".tr,
//                         iconData: Icons.email_outlined,
//                         mycontroller: controller.email,
//                         valid : (val){
//                           return validInput(val!, 5, 100, "email");
//                         }, isNumber: false,
//                       ),
//
//
//                       SizedBox(height: 30,),
//                       CustomButtonAuth(text: "ارسال",onPressed: (){
//                         controller.checkEmail();
//                       },),
//                     ],)
//
//                   )],
//                   ),
//                 ),
//               ),
//         Positioned(
//           top: 40,
//           left: 20,
//           child: IconButton(
//             icon: const Icon(
//               Icons.arrow_forward_ios,
//               color: AppColor.thirdColor,
//               size: 25,
//             ),
//             onPressed: () {
//
//               controller.goToLogin();
//             },
//           ),
//         ),
//    ] ))
//          ,)
//     );
//   }
// }
