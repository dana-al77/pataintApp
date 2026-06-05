import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controller/home/medical_tips.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/class/statusrequest.dart';
import '../../handle_empty.dart';
import '../../skelton/tips_skeleton.dart';
import 'medical_tip_card.dart';

class ListMedicalTipsHome extends StatelessWidget {
  const ListMedicalTipsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewMedicalTipsControllerImp());

    return GetBuilder<ViewMedicalTipsControllerImp>(
      builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,

          // ✅ Skeleton Loading
          loadingWidget: SizedBox(
            height: 110.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: const MedicalTipSkeleton(),
                );
              },
            ),
          ),

          // ✅ Retry
          onRetry: () {
            controller.getMedicalTips();
          },

          // ✅ Main Widget
          widget: controller.data.isEmpty
              ? const EmptyStateWidget(
            title: "لا توجد نصائح حالياً",
            subtitle: "حاول لاحقاً",
            icon: Icons.tips_and_updates_outlined,
          )
              : SizedBox(
            height: 110.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final tip = controller.data[index];

                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
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
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controller/home/medical_tips.dart';
// import '../../../../controller/home_controller.dart';
// import '../../../../core/class/statusrequest.dart';
// import '../../../../core/constant/color.dart';
// import 'medical_tip_card.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class ListMedicalTipsHome extends StatelessWidget {
//   const ListMedicalTipsHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ViewMedicalTipsControllerImp());
//
//     return GetBuilder<ViewMedicalTipsControllerImp>(
//       builder: (controller) {
//         // 👇 معالجة حالات التحميل (اختياري بس مهم)
//         if (controller.statusRequest == StatusRequest.loading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.data.isEmpty) {
//           return const Center(child: Text("لا توجد نصائح حالياً"));
//         }
//
//         return Container(
//           height: 110.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemCount: controller.data.length,
//             itemBuilder: (context, index) {
//               final tip = controller.data[index];
//
//               return Padding(
//                 padding:  EdgeInsets.only(right: 10.w),
//                 child: SizedBox(
//                   width: 160.w,
//                   child: ModernGridCard(
//                     title: tip.title!,
//                     content: "${tip.content}",
//
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// /*
