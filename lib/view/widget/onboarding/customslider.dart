import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onboardingcontroller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageasset.dart';
import '../../../data/datasource/static/static.dart';
import '../clipper/glass.dart';
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


            // Positioned.fill(
            //   child: Image.asset(
            //     onBoardingList[i].image!,
            //     fit: BoxFit.cover, // مهم جداً
            //   ),
            // ),

            Positioned.fill(
              child: Image.asset(
                AppImageAsset.DNA, // حط مسار صورة DNA تبعك
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColor.white.withOpacity(0.3), // 👈 قوي
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 190,
              right: -40, // يطلع برا شوي (مهم)
              child: Image.asset(
                onBoardingList[i].image!,
                height: 500, // 👈 كبرناه
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  // الطبقة الزجاجية
                  ClipPath(
                    clipper: GlassClipper(),
                    clipBehavior: Clip.antiAlias,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 370,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),

                  // الخط الأبيض
                  ClipPath(
                    clipper: GlassClipper(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 370, // 👈 نفس الارتفاع
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25), // خففناه شوي
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /// 🔵 زر تخطي
            ///
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
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 20,
              right: 189,
              child: Builder(
                builder: (_) {
                  String title = onBoardingList[i].title!;
                  List<String> lines = title.split("\n");

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// السطر الأول
                      Text(
                        lines[0],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),

                      SizedBox(height: 5),

                      /// السطر الثاني
                      if (lines.length > 1)
                        Text(
                          lines[1],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondyColor,
                          ),
                        ),

                      SizedBox(height: 15),

                      /// الوصف
                      Text(
                        onBoardingList[i].body!,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.8,
                          color: Colors.black54,
                        ),
                      ),




                    ],
                  );
                },
              ),
            ),
           Column(
            //
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
            //     const SizedBox(height: 550),
            //
            //     Text(
            //       onBoardingList[i].title!,
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //         color: AppColor.primaryColor,
            //       ),
            //     ),
            //
            //     const SizedBox(height: 17),
            //
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       child: Text(
            //         onBoardingList[i].body!,
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           height: 1.8,
            //           fontSize: 14,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //
                const Spacer(),
            //
            //     /// النقاط + الزر
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