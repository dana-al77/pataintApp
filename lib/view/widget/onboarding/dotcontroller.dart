import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onboardingcontroller.dart';
import '../../../core/constant/color.dart';
import '../../../data/datasource/static/static.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<OnBoardingcontrollerImp>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(onBoardingList.length, (index) => AnimatedContainer(
            margin: const EdgeInsets.only(right: 5),
            duration: Duration(
              milliseconds: 900,
            ),width: controller.currentPage== index ? 26 :10,
            height: 5,
            decoration: BoxDecoration(
              color: controller.currentPage == index
                  ? AppColor.secondyColor
                  : AppColor.inactiveDotColor,
              borderRadius: BorderRadius.circular(10),
            ),

          ),)
        ],);
    },)
    ;
  }
}
