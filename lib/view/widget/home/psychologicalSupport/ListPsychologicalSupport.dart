import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/link_api.dart';

import '../../../../controller/home/Support_controller.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/color.dart';
import '../../../../data/model/support_model.dart';
import 'PsychologicalSupport_card.dart';
//
//
// class ListMPsychologicalSupport extends StatelessWidget {
//   const ListMPsychologicalSupport({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(SupportControllerImp());
//
//     return GetBuilder<SupportControllerImp>(
//       builder: (controller) {
//         // 👇 معالجة حالات التحميل (اختياري بس مهم)
//         if (controller.statusRequest == StatusRequest.loading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.data.isEmpty) {
//           return const Center(child: Text("لا توجد دعم  حالياً"));
//         }
//
//         return SizedBox(
//           height: 175,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: controller.data.length,
//             itemBuilder: (context, index) {
//               final supp = controller.data[index];
//
//               return PsychologicalSupportCard(
//                 title: supp.title!,
//                 content: "${supp.content}",
//                 createdBy: 'د.${supp.createdBy}',
//                 image: '',              );
//             },
//           ),
//         );
//       },
//     );
//   }
// }


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