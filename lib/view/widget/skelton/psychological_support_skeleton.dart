import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_shimmer.dart';
import '../shimmer/shimmer.dart';

class PsychologicalSupportSkeleton extends StatelessWidget {
  const PsychologicalSupportSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: 320.w,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // ✅ صورة وهمية
            AppSkeleton(
              height: 80.h,
              width: 80.w,
              radius: 15.r,
            ),

            SizedBox(width: 15.w),

            // ✅ نصوص وهمية
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSkeleton(
                    height: 14.h,
                    width: 120.w,
                  ),

                  SizedBox(height: 12.h),

                  AppSkeleton(
                    height: 10.h,
                    width: double.infinity,
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