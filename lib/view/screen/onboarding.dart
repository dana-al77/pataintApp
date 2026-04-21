import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/onboardingcontroller.dart';
import '../../core/constant/color.dart';
import '../widget/onboarding/custombutton.dart';
import '../widget/onboarding/customslider.dart';
import '../widget/onboarding/dotcontroller.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingcontrollerImp());

    return Scaffold(
      body: Column(
              children: [
                Expanded(
                  child: CustomSliderOnBoarding(),
                ),
              ],
            ),


    );
  }
}