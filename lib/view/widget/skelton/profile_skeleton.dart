import 'package:flutter/material.dart';
import '../../../core/constant/app_shimmer.dart';
import '../shimmer/shimmer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  Widget _row() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Row(
        children: [
          const AppSkeleton(
            height: 42,
            width: 42,
            radius: 21,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppSkeleton(
                  height: 12,
                  width: 90,
                ),
                SizedBox(height: 8),
                AppSkeleton(
                  height: 14,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        child: Column(
          children: [

            // نفس مساحة الهيدر
            Container(
              height: 240,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [

                  const SizedBox(height: 55),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppSkeleton(
                        height: 35,
                        width: 35,
                        radius: 10,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // صورة البروفايل
                  const AppSkeleton(
                    height: 90,
                    width: 90,
                    radius: 45,
                  ),

                  const SizedBox(height: 16),

                  // الاسم
                  const AppSkeleton(
                    height: 18,
                    width: 140,
                  ),

                  const SizedBox(height: 10),

                  // الإيميل
                  const AppSkeleton(
                    height: 14,
                    width: 220,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // كرت المعلومات
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _row(),
                  Divider(height: 1),
                  _row(),
                  Divider(height: 1),
                  _row(),
                  Divider(height: 1),
                  _row(),
                  Divider(height: 1),
                  _row(),
                  Divider(height: 1),
                  _row(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // زر Logout
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const AppSkeleton(
                height: 55,
                width: double.infinity,
                radius: 16,
              ),
            ),

            const SizedBox(height: 16),

            // Verified Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const AppSkeleton(
                height: 90,
                width: double.infinity,
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}