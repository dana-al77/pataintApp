
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:patientapp/view/widget/auth/customtextbodyauth.dart';
import 'package:patientapp/view/widget/auth/customtexttitlleauth.dart';


class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomTextTitleAuth(text: "22".tr,),
        SizedBox(height: 10,),
        CustomTextBodyAuth(text: "23".tr,),
        SizedBox(height: 65,),

        ListView(
        //  padding: EdgeInsets.all(20),
          children: [
            OtpTextField(
             fieldWidth: 50.0,
             borderRadius: BorderRadius.circular(20),
              numberOfFields: 5,
              borderColor: Color(0xFF512DAB),
              showFieldAsBox: true,
              onCodeChanged: (String Code){

              },
              onSubmit: (String verificationCode){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(title:Text("21".tr) ,content:Text("24".tr) ,);
                  },);
              },
            )
          ],),



      ],),
    );
  }
}
/*
*  var res;
  initdata() async {
    res =await checkInternet();
    print(res);
  }

  @override
  void initState() {
    initdata();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(child: Text("dannnnn"),),
    );
  }*/