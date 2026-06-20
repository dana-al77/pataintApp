import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../core/constant/color.dart';
import '../widget/home/ListServicesHome.dart';
import '../widget/home/card_condact_doctor.dart';
import '../widget/home/centerInfo/cente_info_card.dart';
import '../widget/home/centerInfo/list_center_info.dart';
import '../widget/home/custom_home_appbar.dart';
import '../widget/home/customsearchfield.dart';
import '../widget/home/doctor/list_doctors_home.dart';
import '../widget/home/tips/list_medical_tips.dart';
import '../widget/home/psychologicalSupport/ListPsychologicalSupport.dart';
import '../widget/home/section_title.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return GetBuilder<HomeControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomHomeAppBar(controller: controller),
      body: GetBuilder<HomeControllerImp>(
        builder: (controller) => ListView(
          children:  [

            DoctorConsultationCard(),
            SectionTitle(title: "الخدمات المتاحة"),
            ListServicesHome(),

            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // إضافة حواف جانبية متناسقة
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // يوزع العناصر على الأطراف تلقائياً
                children: [
                  SectionTitle(title: "الأطباء المتميزون"),

                  // جزء "عرض الكل" مع السهم كما في الصورة
                  InkWell(
                    onTap: () {
                    controller.seeAllDoctor();
                             },
                    child: Row(
                      children: [
                        Text(
                          "عرض الكل",
                          style: TextStyle(
                            color:AppColor.secondyColor, // لون الـ Teal المتناسق مع تطبيقك
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios, // السهم الصغير الموجود في الصورة
                          size: 14.sp,
                          color:AppColor.secondyColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ListDoctorsHome(limit: 3),
            SectionTitle(title: "النصائح الطبية"),
            ListMedicalTipsHome(),
           //
            SectionTitle(title: "قسم الصحة النفسية"),
            ListMPsychologicalSupport(),
            //ListCenterInfo(),
          ],
        )
      ),
    )
      );
  }
}