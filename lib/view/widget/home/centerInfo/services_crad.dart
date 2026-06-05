import 'package:flutter/material.dart';
import '../../../../core/constant/color.dart';
import '../section_title.dart';

// أضفنا BuildContext context هنا
Widget buildServicesCard(BuildContext context, String services) {
  // تحويل النص القادم من السيرفر إلى قائمة

  final servicesList = services.split("-").where((s) => s.trim().isNotEmpty).toList();

  List<String> displayedList = servicesList.take(5).toList();  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(title: "الخدمات المتوفرة",),
            TextButton(
              onPressed: () {
                _showAllServicesBottomSheet(context, servicesList);
              },
              child: Row(
                children: [
                  Text("عرض الكل", style: TextStyle(color: AppColor.secondyColor)),
                  Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.secondyColor),
                ],
              ),
            ),
          ],
        ),
      ),

      /// شبكة الخدمات
      /// شبكة الخدمات - التعديل هنا لضمان التناسق التام
      /// شبكة الخدمات - التعديل هنا لضمان المسافات المتناسقة
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          padding: EdgeInsets.zero, // 1. ضيفي هذا السطر لتصفير المسافات الافتراضية
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedList.length + (servicesList.length > 5 ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,    // 2. قللي المسافة العمودية بين الصفوف من 20 إلى 10
            crossAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            if (index == 5 && servicesList.length > 5) {
              return _buildMoreItem(context, () {
                _showAllServicesBottomSheet(context, servicesList);
              });
            }
            return _buildServiceGridItem(context, displayedList[index].trim());
          },
        ),
      ),
    ],
  )
    ]
  );
}

Widget _buildMoreItem(BuildContext context, VoidCallback onTap) {
  double screenWidth = MediaQuery.of(context).size.width;
  // نفس الحسبة لضمان تناسق الأحجام (4 أعمدة)
  double itemWidth = (screenWidth - 32 - (3 * 15)) / 4;

  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: itemWidth,
      child: Column(
        children: [
          Container(
            width: itemWidth * 0.9,
            height: itemWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1), // خلفية رمادية فاتحة
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.more_horiz, // أيقونة النقاط الثلاث
              color: Colors.grey,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "المزيد",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
void _showAllServicesBottomSheet(BuildContext context, List<String> allServices) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder( // تم التصحيح هنا
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "جميع الخدمات الطبية",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColor.secondyColor, // استخدام اللون الأزرق المعتمد لمشروعك
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemCount: allServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceGridItem(context, allServices[index].trim());
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
Widget _buildServiceGridItem(BuildContext context, String title) {
  // الآن context معرف ولن يظهر خطأ
  double screenWidth = MediaQuery.of(context).size.width;

  // حساب العرض لضمان 4 أعمدة متساوية (المسافة الكلية - البادينغ - الفراغات بين العناصر)
  double itemWidth = (screenWidth - 32 - (3 * 15)) / 4;

  // اختيار اللون: إذا كان النص يحتوي "قلب" نستخدم الأحمر، وإلا نستخدم لون التطبيق الأساسي
  Color baseColor = title.contains("قلب") ? Colors.redAccent : AppColor.secondyColor;

  return SizedBox(
    width: itemWidth,
    child: Column(
      children: [
        Container(
          width: itemWidth * 0.9,
          height: itemWidth * 0.9,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            _getServiceIcon(title),
            color: baseColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11, // صغرنا الخط قليلاً ليتناسب مع الـ 4 أعمدة
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
// دالة بسيطة لاختيار الأيقونة بناءً على اسم الخدمة (اختياري)
IconData _getServiceIcon(String title) {
  if (title.contains("قلب")) return Icons.favorite_outline;
  if (title.contains("أشعة")) return Icons.monitor_heart_outlined;
  if (title.contains("مختبر")) return Icons.biotech_outlined;
  return Icons.medical_services_outlined; // أيقونة افتراضية
}