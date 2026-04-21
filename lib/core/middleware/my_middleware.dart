
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/routes.dart';
import '../services/services.dart';

class MyMiddeeWare extends GetMiddleware{

  int? get priority => 1;

  MyServices myServices =Get.find();

  @override
  RouteSettings? redirect(String? route) {


    String? step = myServices.sharedPreferences.getString("step");
    if (step == "5") {
      return RouteSettings(name: AppRoute.HomeScreen);
    }
    if (step == "4") {
      return RouteSettings(name: AppRoute.verfiycode);
    }
/// completeprofile
    if (step == "3") {
      return RouteSettings(name: AppRoute.login);
    }
///  regiter
    if (step == "2") {
      return RouteSettings(name: AppRoute.completeProfile);
    }
//// onboarding
    if (step == "1") {
      return RouteSettings(name: AppRoute.login);
    }

    return null;

   }


}