import 'package:flutter/material.dart';
import '../../../../controller/home/doctor_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/class/statusrequest.dart';
import '../../handle_empty.dart';
import '../../shimmer/fade_slide.dart';
import 'doctor_card.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'doctor_card_skeleton.dart';

class ListDoctorsHome extends StatelessWidget {
  final int? limit;
  const ListDoctorsHome({super.key, this.limit});

  @override
  Widget build(BuildContext context) {
    Get.put(DoctorControllerImp());

    return GetBuilder<DoctorControllerImp>(
      builder: (controller) {


        return HandlingDataRequest(
          statusRequest: controller.statusRequest,

          // 🔥 مرر skeleton خاص لهي الشاشة
            loadingWidget: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const DoctorCardSkeleton();
              },
            ),

          onRetry: () {
            controller.getDoctors();
          },

          widget: controller.data.isEmpty
              ? const EmptyStateWidget(
            title: "لا يوجد أطباء حالياً",
            subtitle: "يمكنك المحاولة لاحقاً",
            icon: Icons.person_search,
          )
              :  ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            // 👇 أهم سطر
            itemCount: limit != null
                ? (controller.data.length > limit!
                ? limit
                : controller.data.length)
                : controller.data.length,

            itemBuilder: (context, index) {
              return DoctorCard(
                doctor: controller.data[index],
              );
            },
          ),
        );
      },
    );
  }
}