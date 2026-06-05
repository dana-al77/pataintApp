import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/widget/home/centerInfo/services_crad.dart';
import '../../../../controller/home/center_info.dart';
import '../../../../core/class/statusrequest.dart';
import '../section_title.dart';
import 'build_card.dart';
import 'cente_info_card.dart';
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
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final model = controller.data.first;

          return SingleChildScrollView(
            child: Column(
              children: [
                CenterHeaderWidget(
                  centerName: "عيادة الرواد الاستشارية", // Static
                  location: model.location ?? "الموقع غير محدد", // Dynamic من السيرفر
                ),

            // داخل دالة الـ build الخاصة بالصفحة:
                SizedBox(height: 10,),
            buildServicesCard(context,model.services ?? ""),

                OpeningHoursCard(
                  openingHours: model.openingHours ?? {},
                ),
                // استدعاء دالة الفروع بداخل GetBuilderbuildBranchesSection(model.branches ?? {}),
                SizedBox(height: 100,),
              ],

            ),
          );
        },
      ),
    );
  }
  Widget buildBranchesSection(Map<String, String> branches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SectionTitle(title: "الفروع التابعة"),
        ),

        // نستخدم .entries.map لأننا نتعامل مع Map
        ...branches.entries.map((entry) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.secondyColor.withOpacity(0.1)),
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
                child: Icon(Icons.location_on_outlined,
                    color: AppColor.secondyColor, size: 22),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم الفرع (Key)
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // عنوان الفرع (Value)
                    Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
            ],
          ),
        )),
      ],
    );
  }
}
