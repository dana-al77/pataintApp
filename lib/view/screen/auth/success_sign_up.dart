
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/successsignupcontroller.dart';
import '../../../core/constant/color.dart';
import '../../widget/auth/custombuttonauth.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SucessSignUpControllerImp controller =Get.put(SucessSignUpControllerImp());
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColor.white,
        //   //   elevation: 0.0,
        //   title: Text("31".tr ,style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColor.grey,),
        //   ),),
        body:

    Container(padding: EdgeInsets.all(15),
    child: Column(
      children: [
      Center(child: Icon(Icons.check_circle_outline,color: AppColor.primaryColor,size:200)),
        Text("................................"),
        Spacer(),
        Container(
          width: double.infinity,
          child: CustomButtonAuth(text: "32".tr,onPressed: (){
         controller.goToPagrLogin();
          },),
        ),
        SizedBox(height: 30,)
    ],),)
    );
  }
}
