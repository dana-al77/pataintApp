import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/appiontement/my_appointments_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/color.dart';
import '../../../widget/appiontement/my-appiontement/appointment_card.dart';
import '../../../widget/customappbar.dart';


class MyAppointmentsView extends StatelessWidget {

  const MyAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(MyAppointmentsController());

    return Scaffold(

      backgroundColor: AppColor.backgroundColor,

      appBar:const PioneersMedicalAppBar(
        icon: Icons.calendar_month_rounded,
        title: "حجوزاتي",

      ),

      body: GetBuilder<MyAppointmentsController>(
        builder: (controller) {
      return HandlingDataModern(
        statusRequest: controller.statusRequest,
        onRetry: () {
          controller.getAppointments();
        },
        widget: Column(
          children: [
            // شريط التبويبات بستايل الإطار الموحد
            Container(
              height: 55, // ارتفاع الشريط
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white, // الإطار الخارجي أبيض
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: customTab(controller, 0, "القادمة")),
                  Expanded(child: customTab(controller, 1, "المكتملة")),
                  Expanded(child: customTab(controller, 2, "الملغية")),
                ],
              ),
            ),
            // --- شريط التبويبات العلوي ---
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       customTab(controller, 0, "القادمة"),
            //       customTab(controller, 1, "المكتملة"),
            //       customTab(controller, 2, "الملغية"),
            //     ],
            //   ),
            // ),

            // --- قائمة الحجوزات المتحركة ---
            Expanded(
              child: controller.currentList.isEmpty
                  ? Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.event_busy_rounded,
                        size: 70,
                        color: AppColor.secondyColor,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "لا توجد حجوزات حالياً",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "عند حجز موعد جديد سيظهر هنا",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.currentList.length,
                itemBuilder: (context, index) {
                  var item = controller.currentList[index];
                  return AppointmentCard(
                    appointment: item,
                    onCancel: controller.selectedTab == 0 ? () {
                      controller.cancelAppointment(item.paymentId!, item.id!);
                    } : null,
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
    ),
    );
  }

  // Widget sectionTitle(String title) {
  //
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 15),
  //
  //     child: Text(
  //       title,
  //       style: const TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
  // Widget customTab(MyAppointmentsController controller, int index, String title) {
  //   bool isSelected = controller.selectedTab == index;
  //   return GestureDetector(
  //     onTap: () => controller.changeTab(index),
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       // نتحكم بالعرض ليكون متناسق
  //       padding: const EdgeInsets.symmetric(vertical: 12),
  //       decoration: BoxDecoration(
  //         // إضافة خط سفلي فقط إذا كان التبويب مختاراً
  //         border: Border(
  //           bottom: BorderSide(
  //             color: isSelected ? AppColor.secondyColor : Colors.transparent,
  //             width: 3, // سماكة الخط تحت النص
  //           ),
  //         ),
  //       ),
  //       child: Text(
  //         title,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           // النص المختار يكون لونه غامق وبارز أكثر
  //           color: isSelected ? AppColor.secondyColor : Colors.grey.shade500,
  //           fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget customTab(MyAppointmentsController controller, int index, String title) {
    bool isSelected = controller.selectedTab == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(4), // مسافة بسيطة بداخل الكونتينر الأبيض
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // المختار بياخد اللون الأخضر (أو لون تطبيقك)، وغير المختار شفاف
          color: isSelected ? AppColor.secondyColor : Colors.transparent,
          borderRadius: BorderRadius.circular(50), // زوايا منحنية للمختار
        ),
        child: Text(
          title,
          style: TextStyle(
            // النص المختار أبيض، وغير المختار رمادي
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}