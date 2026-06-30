import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home/services.dart';
import 'CustomServiceItem.dart';
class ListServicesHome extends StatelessWidget {
  const ListServicesHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(servicesControllerImp());
    return GetBuilder<servicesControllerImp>(
      builder:(controller) {
     return   Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CustomServiceItem(
              //   title: "السجل الطبي",
              //   icon: Icons.qr_code_2_sharp,
              //   backgroundColor: Colors.blue,
              //   iconColor: Colors.blue,
              //   onTap: () {
              //     print("NAVIGATING TO TAB QR");
              //     controller.goToQR();
              //
              //   },
              // ),
              CustomServiceItem(
                title: "دردشة",
                icon: Icons.mark_chat_read_outlined,
                backgroundColor: Colors.blue,
                iconColor: Colors.blue,
                onTap: () {
                  controller.goToConsultant();

                },
              ),
              CustomServiceItem(
                title: "رفع التحاليل",
                icon: Icons.upload_file,
                backgroundColor: Colors.orange,
                iconColor: Colors.orange,
                onTap: () {
                  controller.goToUpLoad();
                },
              ),
              CustomServiceItem(
                title: "الجلسات",
                icon: Icons.chat_outlined,
                backgroundColor: Colors.purple,
                iconColor: Colors.purple,
                onTap: () {},
              ),
              CustomServiceItem(
                title: "حجز موعد",
                icon: Icons.calendar_month_outlined,
                backgroundColor: Colors.teal,
                iconColor: Colors.teal,
                onTap: () {
                  controller.goToFirstAppiont();
                },
              ),
            ],
          )
        );
      },
    );
  }
}