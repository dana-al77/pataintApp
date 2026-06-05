import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_shimmer.dart';
import '../shimmer/shimmer.dart';

class MedicalTipSkeleton extends StatelessWidget {
  const MedicalTipSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSkeleton(
              height: 14.h,
              width: 90.w,
              radius: 8,
            ),

            SizedBox(height: 12.h),

            AppSkeleton(
              height: 10.h,
              width: 130.w,
              radius: 8,
            ),

            SizedBox(height: 8.h),

            AppSkeleton(
              height: 10.h,
              width: 100.w,
              radius: 8,
            ),

            const Spacer(),

            Align(
              alignment: Alignment.bottomRight,
              child: AppSkeleton(
                height: 28.h,
                width: 28.w,
                radius: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}