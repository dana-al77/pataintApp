import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../../../core/constant/imageasset.dart';
import '../../../../data/model/doctor.dart';
import '../../../screen/doctor/doctor_details.dart';
import 'doctor_info_row.dart';
import 'package:get/get.dart';
class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // تأخذ العرض الكامل
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w), // إضافة مساحة داخلية للكارت
      decoration: BoxDecoration(
        color:AppColor.secondyColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.001),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          )
        ],
      ),
      child: Row( // تغيير من Column إلى Row
        children: [
          /// 🖼 صورة الطبيب (بشكل مربع منحني الأطراف)
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              AppImageAsset.doctor,
              height: 85.h,
              width: 85.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 15.w),

          /// 📝 بيانات الطبيب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "د. ${doctor.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    // زر الاتصال الملون كما في الصورة
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DoctorDetailsPage(
                          doctor: doctor,
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
                        decoration: BoxDecoration(
                          color: AppColor.secondyColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "حجز",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //SizedBox(height: 5.h),

                DoctorInfoRow(
                 icon: Icons.medical_services_outlined,
                  text: doctor.specialization ?? "General Doctor",
                  iconColor: Colors.grey,
                ),

                SizedBox(height: 5.h),

                Row(
                  children: [
                    DoctorInfoRow(
                     icon: Icons.work,
                      text: "${doctor.experienceYears} years",
                      iconColor: Colors.grey,
                    ),
                    SizedBox(width: 100.w),
                    DoctorInfoRow(
                      icon: Icons.star,
                      text: "4.8",
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}