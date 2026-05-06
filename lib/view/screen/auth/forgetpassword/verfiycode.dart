
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/forgetpassword/verfiycodecontroller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/imageasset.dart';

import '../../../widget/auth/CustomOtpField.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtexttitlleauth.dart';

class VerfiyCodeForPass extends StatelessWidget {
  const VerfiyCodeForPass({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerfiyCodePasscontrollerImp());

    return Scaffold(
      body: GetBuilder<VerfiyCodePasscontrollerImp>(
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
                            Image.asset(
                              AppImageAsset.logoo,
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

                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.25),
                                    Colors.white.withOpacity(0.3),
                                  ],
                                ),

                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [

                                  /// 📝 العناوين
                                  CustomTextTitleAuth(
                                      text: "التحقق من حسابك"),
                                  CustomTextBodyAuth(
                                      text:
                                      "أدخل الرمز المرسل إلى بريدك الإلكتروني\n${controller.email}"),

                                  const SizedBox(height: 25),

                                  /// 🔢 OTP داخل Glass خفيف
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 0),
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //   BorderRadius.circular(15),
                                    //   color: Colors.white.withOpacity(0.2),
                                    //   border: Border.all(
                                    //     color: Colors.white
                                    //         .withOpacity(0.25),
                                    //   ),
                                    // ),

                                    child: CustomOtpField(
                                      numberOfFields: 6,
                                      onSubmit: (code) {
                                        controller
                                            .goToresetPassword(code);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔙 رجوع (اختياري)
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.secondyColor,
                  ),
                  onPressed: () {
                    Get.back();
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
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import '../../../../controller/forgetpassword/verfiycodecontroller.dart';
// import '../../../../core/class/handling_data_view.dart';
// import '../../../../core/constant/color.dart';
// import '../../../../core/constant/imageasset.dart';
// import '../../../widget/auth/CustomOtpField.dart';
// import '../../../widget/auth/customtextbodyauth.dart';
// import '../../../widget/auth/customtexttitlleauth.dart';
//
// class VerfiyCodeForPass extends StatelessWidget {
//   const VerfiyCodeForPass({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//       Get.put(VerfiyCodePasscontrollerImp());
//     return Scaffold(
//
//         body: GetBuilder<VerfiyCodePasscontrollerImp>(builder: (controller) =>
//     handlingDataRequest(statusRequest:  controller.statusRequest,
//     widget:  Stack(
//       children:[
//         Positioned.fill(
//           child: Image.asset(
//             AppImageAsset.verfiycode,
//             fit: BoxFit.cover,
//             alignment: Alignment.center,
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//           ),
//         ),
//         // Positioned(
//         //   top: 40,
//         //   left: 20,
//         //   child: IconButton(
//         //     icon: const Icon(
//         //       Icons.arrow_forward_ios,
//         //       color: AppColor.thirdColor,
//         //       size: 25,
//         //     ),
//         //     onPressed: () {
//         //       controller.goToLogin();
//         //     },
//         //   ),
//         // ),
//         Container(
//                 padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
//                 child: ListView(children: [
//
//                   SizedBox(height: 200,),
//                   CustomTextTitleAuth(text: "التحقق من حسابك ",),
//                   SizedBox(height: 10,),
//                   CustomTextBodyAuth(text:"يرجى إدخال الرمز الذي أرسلناه إلى بريدك الإلكتروني${controller.email}",),
//
//                   SizedBox(
//             height: 26,
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.15,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               color: AppColor.backgroundColor,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: Colors.blue.shade100.withOpacity(0.5),
//                 width: 1.2,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 15,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//                   child: Center( // هذا سيجعل الحقول في منتصف الصندوق الأبيض تماماً
//                     child: CustomOtpField(
//                       numberOfFields: 6,
//                       onSubmit: (code) {
//                         controller.goToresetPassword(code);
//                       },
//                     ),
//
//                   ),
//
//
//           ),
//                   SizedBox(height: 20),
//
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.start,
//                   //   children: [
//                   //     Text(
//                   //       "لم يصلك الرمز؟ ",
//                   //       style: TextStyle(
//                   //         color: AppColor.black,
//                   //         fontSize: 14,
//                   //       ),
//                   //     ),
//                   //     InkWell(
//                   //       onTap: () {
//                   //      //   controller.resendOtp();
//                   //       },
//                   //       child: Text(
//                   //         "إعادة إرسال",
//                   //         style: TextStyle(
//                   //           color: AppColor.thirdColor,
//                   //           fontWeight: FontWeight.bold,
//                   //           fontSize: 14,
//                   //           decoration: TextDecoration.underline,
//                   //         ),
//                   //       ),
//                   //     ),
//                   //
//                   //   ],
//                   // ),
//
//                 ],),
//
//
//
//
//       ),
//    ] ))
//           ,)
//     );
//   }
// }
