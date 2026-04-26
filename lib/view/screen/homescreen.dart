import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/homescreen_controller.dart';
import '../../controller/notification_controller.dart';
import '../../core/constant/color.dart';
import '../widget/custombottomappbarhome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    Get.put(NotificationController());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.white,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const CustomBottomAppBarHome(),
        body: controller.listPage[controller.currentpage],
      ),
    );
  }
}
