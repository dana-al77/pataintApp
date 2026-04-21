
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';
import '../data/datasource/static/static.dart';
///  لي abstract لان بيوضحلي كل ميثود بكل سكرين
abstract class OnBoradingController extends GetxController{

  // الفنكشن الاولة مهمتها بس اضغط على الزر بتنقلي على البيج الي بعدها تبع زر continue
  next();
  ///// لما بتنقل بالبيج بشكل عام من دون الضغط على الزر بيتفعل الكونرولر
  // انتبه انو هون بتستقبل متغير يعني يفي البداية بتكون البيج 0 لما بتنقل للصفحة التانية بيصير المتغير 1 وهيك للباقي
onPageChanged(int index);

}

class OnBoardingcontrollerImp extends OnBoradingController{

  int currentPage=0;
  late PageController pagecontroller;
  MyServices myServices = Get.find();

  @override
  next() {
    currentPage++;
    if(currentPage > onBoardingList.length - 1){
      myServices.sharedPreferences.setString("step", "1");
  Get.offAllNamed(AppRoute.login);
    }
else{
      pagecontroller.animateToPage(currentPage, duration: Duration(milliseconds: 900), curve: Curves.easeInOut);

    }
  }
  void skip() {
    myServices.sharedPreferences.setString("step", "1");
    Get.offAllNamed(AppRoute.login);
  }
  @override
  onPageChanged(int index) {
    currentPage=index;
    update();
  }

  @override
  void onInit() {
    pagecontroller=PageController();
    super.onInit();
  }

}