import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_shimmer.dart';
import '../shimmer/shimmer.dart';

class DoctorCardSkeleton extends StatelessWidget {
  const DoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // 🖼 صورة وهمية
            AppSkeleton(height: 85.h, width: 85.w, radius: 15),

            SizedBox(width: 15.w),

            // 📝 النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton(height: 12, width: 120),

                  SizedBox(height: 8),

                  AppSkeleton(height: 10, width: 100),

                  SizedBox(height: 8),

                  Row(
                    children: [
                      AppSkeleton(height: 10, width: 60),
                      SizedBox(width: 20),
                      AppSkeleton(height: 10, width: 40),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}