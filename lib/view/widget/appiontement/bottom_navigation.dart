import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/appiontement/first_appion_controller.dart';
import '../../../core/constant/color.dart';
import 'button.dart';

Widget navigationBar(FistAppiontController c) {
  return GetBuilder<FistAppiontController>(builder: (controller) =>
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GetBuilder<FistAppiontController>(
            builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (c.currentStep > 0)
                  TextButton(
                    onPressed: c.prevStep,
                    child: const Text("رجوع",style: TextStyle(fontSize: 18,color: AppColor.secondyColor),),
                  ),

                GradientButton(
                  text: controller.isLastStep ? "تأكيد الحجز" : "التالي",
                  onPressed: controller.handleNextOrSubmit,
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
        ),
      )
  );
}
