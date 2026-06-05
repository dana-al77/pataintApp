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
          bottom: 10, // لإعطاء تأثير البروز خارج حدود الصورة
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
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.only(
        //   bottomLeft: Radius.circular(35),
        //   bottomRight: Radius.circular(35),
        // ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          // تلوين الصورة بطبقة زرقاء طبية شفافة
          colorFilter: ColorFilter.mode(
            AppColor.black.withOpacity(0.004), // درجة الشفافية
            BlendMode.darken, // طريقة دمج اللون مع الصورة
          ),
        ),
      ),
      // هذا الـ Container الداخلي لإضافة تدرج (Gradient) خفيف ليبرز زر الرجوع
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2), // تظليل علوي للأيقونات
              Colors.transparent,
              AppColor.secondyColor.withOpacity(0.2), // تظليل سفلي خفيف
            ],
          ),
        ),
      ),
    );
  }
  // مكوّن البطاقة العائمة
  Widget _buildFloatingInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          centerName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColor.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.white,
                  height: 1.4,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min, // مهم جداً عشان الرو نفسه ما ياخد العرض كامل
          children: [
            Container(
              margin: EdgeInsets.all(6.0),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF2E7D32),
              ),
              child: Text(
                "مفتوح الآن",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}