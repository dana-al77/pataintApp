import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/widget/home/centerInfo/services_crad.dart';

import '../../../../controller/home/center_info.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/class/statusrequest.dart';
import '../section_title.dart';
import 'cente_info_card.dart';
import 'center_info_row.dart';
import 'new/header.dart';

class ListCenterInfo extends StatelessWidget {
  const ListCenterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewCenetrInfoControllerImp());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GetBuilder<ViewCenetrInfoControllerImp>(
        builder: (controller) {
          return HandlingDataModern(
            statusRequest: controller.statusRequest,
            onRetry: () {
              controller.getCenterInfo(); // أو اسم دالة الجلب عندك
            },
            widget: controller.data.isEmpty
                ? const Center(
              child: Text("لا توجد بيانات متاحة"),
            )
                : _buildContent(controller),
          );
        },
      ),
    );
  }

  Widget _buildContent(ViewCenetrInfoControllerImp controller) {
    final model = controller.data.first;

    return SingleChildScrollView(
      child: Column(
        children: [
          CenterHeaderWidget(
            centerName: "عيادة الرواد الاستشارية",
            location: model.location ?? "الموقع غير محدد",
          ),

          const SizedBox(height: 10),

          Container(
            color: AppColor.backgroundColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                return CenterInfoCard(
                  center: controller.data[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget buildBranchesSection(String branches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: SectionTitle(title: "الفروع التابعة"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColor.secondyColor.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.secondyColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_city_outlined,
                  color: AppColor.secondyColor,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  branches,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoSection({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: SectionTitle(title: title),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColor.secondyColor.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.secondyColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColor.secondyColor,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}