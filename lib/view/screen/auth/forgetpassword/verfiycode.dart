import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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

        body: GetBuilder<VerfiyCodePasscontrollerImp>(builder: (controller) =>
    handlingDataRequest(statusRequest:  controller.statusRequest,
    widget:  Stack(
      children:[
        Positioned.fill(
          child: Image.asset(
            AppImageAsset.verfiycode,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned.fill(
          child: Container(
          ),
        ),
        // Positioned(
        //   top: 40,
        //   left: 20,
        //   child: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_forward_ios,
        //       color: AppColor.thirdColor,
        //       size: 25,
        //     ),
        //     onPressed: () {
        //       controller.goToLogin();
        //     },
        //   ),
        // ),
        Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: ListView(children: [

                  SizedBox(height: 200,),
                  CustomTextTitleAuth(text: "التحقق من حسابك ",),
                  SizedBox(height: 10,),
                  CustomTextBodyAuth(text:"يرجى إدخال الرمز الذي أرسلناه إلى بريدك الإلكتروني${controller.email}",),

                  SizedBox(
            height: 26,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.shade100.withOpacity(0.5),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
                  child: Center( // هذا سيجعل الحقول في منتصف الصندوق الأبيض تماماً
                    child: CustomOtpField(
                      numberOfFields: 6,
                      onSubmit: (code) {
                        controller.goToresetPassword(code);
                      },
                    ),

                  ),


          ),
                  SizedBox(height: 20),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "لم يصلك الرمز؟ ",
                  //       style: TextStyle(
                  //         color: AppColor.black,
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //      //   controller.resendOtp();
                  //       },
                  //       child: Text(
                  //         "إعادة إرسال",
                  //         style: TextStyle(
                  //           color: AppColor.thirdColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 14,
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       ),
                  //     ),
                  //
                  //   ],
                  // ),

                ],),




      ),
   ] ))
          ,)
    );
  }
}
