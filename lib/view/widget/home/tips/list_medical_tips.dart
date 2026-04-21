import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/home/medical_tips.dart';
import '../../../../controller/home_controller.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/color.dart';
import 'medical_tip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListMedicalTipsHome extends StatelessWidget {
  const ListMedicalTipsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewMedicalTipsControllerImp());

    return GetBuilder<ViewMedicalTipsControllerImp>(
      builder: (controller) {
        // 👇 معالجة حالات التحميل (اختياري بس مهم)
        if (controller.statusRequest == StatusRequest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.data.isEmpty) {
          return const Center(child: Text("لا توجد نصائح حالياً"));
        }

        return Container(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              final tip = controller.data[index];

              return Padding(
                padding:  EdgeInsets.only(right: 10.w),
                child: SizedBox(
                  width: 160.w,
                  child: ModernGridCard(
                    title: tip.title!,
                    content: "${tip.content}",

                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
/*
GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            itemCount:controller.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final tip = controller.data[index];

              return AnimatedCard(
                child: ModernGridCard(
                  title: tip.title ?? "",
                  content: tip.content ?? "",
                ),
              );
            },

        );
 */