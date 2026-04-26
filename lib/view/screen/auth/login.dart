
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/imageasset.dart';
import '../../../controller/auth/logincontroller.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/valid_input.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitlleauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => Stack(
            children: [

              /// 🌌 الخلفية (DNA)
              Positioned.fill(
                child: Image.asset(
                  AppImageAsset.DNABackGround2,
                  fit: BoxFit.cover,
                ),
              ),

              /// 🌫️ Blur Overlay
              // Positioned.fill(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              //     child: Container(
              //       color: Colors.white.withOpacity(0.1),
              //     ),
              //   ),
              // ),

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
                         //   const SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Pioneers",
                                    style: TextStyle(
                                      color:AppColor.secondyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Clinic",
                                    style: TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              style: const TextStyle(fontSize: 26),
                            ),

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

                                // 🎨 تدرج زجاجي مثل الصورة
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.25),
                                    Colors.white.withOpacity(0.3),
                                  ],
                                ),

                                // ✨ بوردر ناعم
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1,
                                ),

                                // 🌫️ ظل خفيف جدا
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
                                    CustomTextTitleAuth(text: "مرحبا بك مجددا"),
                                    CustomTextBodyAuth(text: "سجل دخولك لمتابعة رحلة تعافيك"),

                                    const SizedBox(height: 25),

                                    CustomTextFormAuth(
                                      hindtext: "اكتب البريد الالكتروني",
                                      labeltext: "البريد الالكتروني",
                                      iconData: Icons.email_outlined,
                                      mycontroller: controller.email,
                                      valid: (val) =>
                                          validInput(val!, 5, 100, "email"),
                                      isNumber: false,
                                    ),

                                    const SizedBox(height: 2),

                                    GetBuilder<LoginControllerImp>(
                                      builder: (_) => CustomTextFormAuth(
                                        obscureText: controller.isShowPassword,
                                        onTapIcon: () =>
                                            controller.showPassword(),
                                        hindtext: "اكتب كلمة السر",
                                        labeltext: "كلمة السر",
                                        iconData: Icons.lock_outline,
                                        mycontroller: controller.password,
                                        valid: (val) => validInput(
                                            val!, 8, 30, "password"),
                                        isNumber: false,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () =>
                                            controller.goToForgetPassword(),
                                        child: const Text(
                                          "نسيت كلمة المرور؟",
                                          style: TextStyle(color:AppColor.secondyColor),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 25),
                                CustomButtonAuth(
                                text: "تسجيل دخول",
                                onPressed: () => controller.login(),
                              ),


                                    const SizedBox(height: 20),

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text("ليس لديك حساب؟ "),
                                        InkWell(
                                          onTap: () =>
                                              controller.goToSignUp(),
                                          child: const Text(
                                            "انشاء حساب",
                                            style: TextStyle(
                                              color: AppColor.secondyColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth/logincontroller.dart';
// import '../../../core/class/handling_data_view.dart';
// import '../../../core/constant/color.dart';
// import '../../../core/constant/imageasset.dart';
// import '../../../core/functions/alertexitapp.dart';
// import '../../../core/functions/valid_input.dart';
// import '../../widget/auth/custombuttonauth.dart';
// import '../../widget/auth/customtextbodyauth.dart';
// import '../../widget/auth/customtextformauth.dart';
// import '../../widget/auth/customtexttitlleauth.dart';
// import '../../widget/auth/logoauth.dart';
//
// class Login extends StatelessWidget {
//   const Login({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(LoginControllerImp());
//     return Scaffold(
//
//
//         body: WillPopScope(
//             onWillPop: alertExitApp,
//           child: GetBuilder<LoginControllerImp>(
//             builder: (controller) => handlingDataRequest(
//               statusRequest: controller.statusRequest,
//               widget: Stack(children: [
//                 Positioned.fill(
//                   child: Image.asset(
//                     AppImageAsset.DNABackGround,
//                     fit: BoxFit.cover,
//                     alignment: Alignment.center,
//                   ),
//                 ),
//
//                 Container(
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   child: Form(
//                     key: controller.formstate,
//                     child: ListView(
//                       children: [
//                         SizedBox(height: 200,),
//                         CustomTextTitleAuth(text: "مرحبا بك مجددا في الرواد الاستشارية",),
//                         CustomTextBodyAuth(text: "سجل دخولك لمتابعة رحلة تعافيك",),
//
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(25),
//                           decoration: BoxDecoration(
//                             color: AppColor.backgroundColor,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: Colors.blue.shade100.withOpacity(0.5),
//                               width: 1.2,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
//                                 blurRadius: 15,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child:
//                           Column(
//                             children: [
//                               CustomTextFormAuth(
//                                 hindtext: "6".tr,
//                                 labeltext: "5".tr,
//                                 iconData: Icons.email_outlined,
//                                 mycontroller: controller.email,
//                                 valid: (val) =>
//                                     validInput(val!, 5, 100, "email"),
//                                 isNumber: false,
//                               ),
//                               const SizedBox(height: 3),
//                               GetBuilder<LoginControllerImp>(
//                                 builder: (_) => CustomTextFormAuth(
//                                   isNumber: false,
//                                   obscureText: controller.isShowPassword,
//                                   onTapIcon: () => controller.showPassword(),
//                                   hindtext: "8".tr,
//                                   labeltext: "7".tr,
//                                   iconData: Icons.lock_outline,
//                                   mycontroller: controller.password,
//                                   valid: (val) =>
//                                       validInput(val!, 8, 30, "password"),
//                                 ),
//                               ),
//
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: InkWell(
//                                   onTap: () => controller.goToForgetPassword(),
//                                   child: Text("9".tr, style: TextStyle(fontSize: 14,color: AppColor.thirdColor)),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               CustomButtonAuth(
//                                 text: "2".tr,
//                                 onPressed: () => controller.login(),
//                               ),
//                               ///////////////////////////
//                               const SizedBox(height: 28),
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "ليس لديك حساب؟ ", // أو استخدم الترجمة "16".tr إذا كانت موجودة
//                                     style: TextStyle(color: AppColor.black, fontSize: 16),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       print("🔥 ضغطت على إنشاء حساب"); // 🔥 هاد راح يظهر بالكونسول
//                                       controller.goToSignUp();
//                                     },
//                                     child: Text(
//                                       "انشاء حساب جديد",
//                                       style: TextStyle(
//                                         color: AppColor.thirdColor,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ) ],
//                     ),
//                   ),
//                 ),
//               ]),
//             )
//         ),
//             )
//     );
//   }
// }
