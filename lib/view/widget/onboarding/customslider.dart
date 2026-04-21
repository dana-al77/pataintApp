import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onboardingcontroller.dart';
import '../../../core/constant/color.dart';
import '../../../data/datasource/static/static.dart';
import 'custombutton.dart';
import 'dotcontroller.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingcontrollerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pagecontroller,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) {
        return Stack(
          children: [


            Positioned.fill(
              child: Image.asset(
                onBoardingList[i].image!,
                fit: BoxFit.cover, // مهم جداً
              ),
            ),
            /// 🔵 زر تخطي
            Positioned(
              top: 50,
              right: 20, // لأن عربي
              child: GestureDetector(
                onTap: () {
                  controller.skip();
                },
                child: Text(
                  "تخطي",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 550),

                Text(
                  onBoardingList[i].title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.primaryColor,
                  ),
                ),

                const SizedBox(height: 17),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    onBoardingList[i].body!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.8,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),

                const Spacer(),

                /// النقاط + الزر
                CustomDotControllerOnBoarding(),
                const SizedBox(height: 20),
                CustomButtonOnBoarding(),
                const SizedBox(height: 40),
              ],
            ),
          ],
        );
      },
    );
  } }