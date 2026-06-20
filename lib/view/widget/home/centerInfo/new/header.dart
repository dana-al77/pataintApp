import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/color.dart';

class CenterHeaderWidget extends StatelessWidget {
  final String centerName;
  final String location;
  final String imagePath;

  const CenterHeaderWidget({
    super.key,
    required this.centerName,
    required this.location,
    this.imagePath = "assets/images/clinic.jpg",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // القسم السفلي: الصورة الرئيسية مع زوايا منحنية
        _buildMainImage(),

        // القسم العلوي: البطاقة المعلوماتية العائمة
        Positioned(
          bottom: 3, // لإعطاء تأثير البروز خارج حدود الصورة
          left: 20,
          right: 20,
          child: _buildFloatingInfoCard(),
        ),
      ],
    );
  }

  // مكوّن الصورة
// مكوّن الصورة مع طبقة اللون (Overlay)
  Widget _buildMainImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.secondyColor,
            AppColor.blueColor
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          Positioned(
            top: 60,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // مكوّن البطاقة العائمة
  Widget _buildFloatingInfoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
     //   color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //    // color: Colors.black.withOpacity(0.12),
        //     blurRadius: 20,
        //     offset: const Offset(0, 8),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            centerName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "رعاية صحية متكاملة وخدمات طبية متميزة",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "مفتوح الآن",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}