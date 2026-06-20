import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controller/home/Support_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/class/statusrequest.dart';
import '../../handle_empty.dart';
import '../../skelton/psychological_support_skeleton.dart';
import 'PsychologicalSupport_card.dart';

class ListMPsychologicalSupport extends StatelessWidget {
  const ListMPsychologicalSupport({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupportControllerImp());

    return GetBuilder<SupportControllerImp>(
      builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,

          // ✅ Skeleton Loading
          loadingWidget: SizedBox(
            height: 320.h,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: const PsychologicalSupportSkeleton(),
                );
              },
            ),
          ),

          // ✅ Retry
          onRetry: () {
            controller.getPsychSupport();
          },

          // ✅ Main Content
          widget: controller.data.isEmpty
              ? const EmptyStateWidget(
            title: "لا يوجد دعم نفسي حالياً",
            subtitle: "حاول لاحقاً",
            icon: Icons.psychology_alt_outlined,
          )
              : SizedBox(
            height: 320.h,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final supp = controller.data[index];

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SizedBox(
                    width: 320.w,
                    child: PsychologicalSupportCard(
                      supportModel: supp,
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




/*

class ListMPsychologicalSupport extends StatelessWidget {
  const ListMPsychologicalSupport({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupportControllerImp());

    return GetBuilder<SupportControllerImp>(
      builder: (controller) {

        // 👇 داتا وهمية مؤقتة
        final dummyData = [
          {
            "title": "التعامل مع القلق",
            "content": "خذ نفس عميق وابتعد عن مصادر التوتر لفترة قصيرة.",
            "image": "https://images.unsplash.com/photo-1493836512294-502baa1986e2"
          },
          {
            "title": "تحسين المزاج",
            "content": "مارس المشي يومياً لمدة 20 دقيقة.",
            "image": "https://images.unsplash.com/photo-1506126613408-eca07ce68773"
          },
          {
            "title": "نوم أفضل",
            "content": "تجنب الهاتف قبل النوم بساعة.",
            "image": "https://images.unsplash.com/photo-1517841905240-472988babdf9"
          },

        ];

        // 👇 إذا في تحميل
        if (controller.statusRequest == StatusRequest.loading &&
            controller.data.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final dataToShow = controller.data.isNotEmpty
            ? controller.data
            : dummyData.map((e) => SupportModel(
          title: e["title"],
          content: e["content"],
          image: e["image"],
        )).toList();

        return  ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataToShow.length,
          itemBuilder: (context, index) {
            return PsychologicalSupportCard(
              supportModel: dataToShow[index],
            );
          },
        );
      },
    );
  }
}
 */