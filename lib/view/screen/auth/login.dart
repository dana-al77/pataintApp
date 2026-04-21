import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/logincontroller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/valid_input.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitlleauth.dart';
import '../../widget/auth/logoauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(


        body: WillPopScope(
            onWillPop: alertExitApp,
          child: GetBuilder<LoginControllerImp>(
            builder: (controller) => handlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Stack(children: [
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
                        CustomTextTitleAuth(text: "مرحبا بك مجددا في الرواد الاستشارية",),
                        CustomTextBodyAuth(text: "سجل دخولك لمتابعة رحلة تعافيك",),

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
                          child:
                          Column(
                            children: [
                              CustomTextFormAuth(
                                hindtext: "6".tr,
                                labeltext: "5".tr,
                                iconData: Icons.email_outlined,
                                mycontroller: controller.email,
                                valid: (val) =>
                                    validInput(val!, 5, 100, "email"),
                                isNumber: false,
                              ),
                              const SizedBox(height: 3),
                              GetBuilder<LoginControllerImp>(
                                builder: (_) => CustomTextFormAuth(
                                  isNumber: false,
                                  obscureText: controller.isShowPassword,
                                  onTapIcon: () => controller.showPassword(),
                                  hindtext: "8".tr,
                                  labeltext: "7".tr,
                                  iconData: Icons.lock_outline,
                                  mycontroller: controller.password,
                                  valid: (val) =>
                                      validInput(val!, 8, 30, "password"),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () => controller.goToForgetPassword(),
                                  child: Text("9".tr, style: TextStyle(fontSize: 14,color: AppColor.thirdColor)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomButtonAuth(
                                text: "2".tr,
                                onPressed: () => controller.login(),
                              ),
                              ///////////////////////////
                              const SizedBox(height: 28),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "ليس لديك حساب؟ ", // أو استخدم الترجمة "16".tr إذا كانت موجودة
                                    style: TextStyle(color: AppColor.black, fontSize: 16),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("🔥 ضغطت على إنشاء حساب"); // 🔥 هاد راح يظهر بالكونسول
                                      controller.goToSignUp();
                                    },
                                    child: Text(
                                      "انشاء حساب جديد",
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
        ),
            )
    );
  }
}
