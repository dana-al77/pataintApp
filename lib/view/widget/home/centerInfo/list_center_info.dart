import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/widget/home/centerInfo/services_crad.dart';
import '../../../../controller/home/center_info.dart';
import '../../../../core/class/statusrequest.dart';
import 'build_card.dart';
import 'cente_info_card.dart';

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

                /// 🖼 صورة الهيدر
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/clinic.jpg"), // غيرها
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// 📍 الموقع
                buildCard(
                  icon: Icons.location_on,
                  title: "الموقع",
                  subtitle: model.location ?? "",
                ),

                /// 🕒 ساعات العمل
                buildCard(
                  icon: Icons.access_time,
                  title: "ساعات العمل",
                  subtitle: model.openingHours ?? "",
                ),

                /// 🗺 الخريطة
                buildCard(
                  icon: Icons.map,
                  title: "العنوان على الخريطة",
                  subtitle: model.addressOnMap ?? "",
                ),

                /// 🏢 الفروع
                buildCard(
                  icon: Icons.account_tree,
                  title: "الفروع",
                  subtitle: model.branches ?? "",
                ),

                /// ❤️ الخدمات
                buildServicesCard(model.services ?? ""),
              ],
            ),
          );
        },
      ),
    );
  }
}
