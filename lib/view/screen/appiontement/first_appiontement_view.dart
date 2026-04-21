import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/screen/appiontement/step1.dart';
import 'package:patientapp/view/screen/appiontement/step2.dart';
import 'package:patientapp/view/screen/appiontement/step3.dart';
import 'package:patientapp/view/screen/appiontement/step4.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import '../../widget/appiontement/Progress.dart';
import '../../widget/appiontement/bottom_navigation.dart';

class FirstAppiontementView extends StatelessWidget {
  const FirstAppiontementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FistAppiontController());

    return Scaffold(
    backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: navigationBar(controller),

      body: GetBuilder<FistAppiontController>(
        builder: (_) =>
            Column(
              children: [
                SizedBox(height: 60,),
                progress(controller),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),

                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },

                    child: getStepWidget(controller),
                  ),
                ),
              ],
            ),
      ),
    );
  }}
Widget getStepWidget(FistAppiontController c) {
  switch (c.currentStep) {
    case 0:
      return const Step1Widget(key: ValueKey(1));
    case 1:
      return const Step2Widget(key: ValueKey(2));
    case 2:
      return const Step3Widget(key: ValueKey(3));
    case 3:
      return const Step4Widget(key: ValueKey(4));
    default:
      return const SizedBox();
  }
}