import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';

Widget buildServicesCard(String services) {
  final servicesList = services.split("-");

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColor.secondyColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [

        /// 🟦 الأيقونة الكبيرة
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.secondyColor.withOpacity(0.2),
                AppColor.secondyColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.favorite, color: AppColor.secondyColor, size: 28),
        ),

        const SizedBox(width: 12),

        /// 📋 المحتوى
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// العنوان + السهم
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الخدمات المتوفرة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14)
                ],
              ),

              const SizedBox(height: 10),

              /// 🟢 الخدمات (عمودين)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: servicesList
                          .sublist(0, (servicesList.length / 2).ceil())
                          .map((e) => _serviceItem(e))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: servicesList
                          .sublist((servicesList.length / 2).ceil())
                          .map((e) => _serviceItem(e))
                          .toList(),
                    ),
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
Widget _serviceItem(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
         Icon(Icons.check_circle,
            color: AppColor.secondyColor, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text.trim(),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}