import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/core/constant/imageasset.dart';

Future<bool> alertExitApp() async {
  return await Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "هل أنت متأكد أنك تريد\nتريد الخروج من التطبيق ؟",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:AppColor.thirdColor, // لون النص الغامق
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "لن يتم حفظ أي تغيرات غير مخزنة",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    // زر الخروج (الأزرق)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColor.secondyColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => exit(0),
                        child: const Text("الخروج", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey, width: 0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => Get.back(),
                        child: const Text("إلغاء", style: TextStyle(color: Color(0xFF2D4F5F))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // أيقونة الأوراق الصغيرة في الأسفل
                const Icon(Icons.eco, color:AppColor.thirdColor, size: 20),
              ],
            ),
          ),
          // الأيقونة العلوية (اللوغو)
          Positioned(
            top: -40,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color:AppColor.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundColor:AppColor.backgroundColor,
                backgroundImage: AssetImage(AppImageAsset.logofordialog), // ضع مسار شعار PC هنا
              ),
            ),
          ),
        ],
      ),
    ),
  ) ?? false;
}
/*
* import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
Future<bool> alertExitApp() async {
  // استخدم الدالة async و await هنا لضمان أن تكون النتيجة صحيحة
  bool result = await Get.defaultDialog(
    title: "تنبيه",
    middleText: "هل تريد الخروج من التطبيق؟",
    actions: [
      ElevatedButton(
        onPressed: () {
          exit(0);
        },
        child: Text("تأكيد"),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("إلغاء"),
      ),
    ],
  );

  // هنا يمكنك إرجاع القيمة بناءً على النتيجة التي حصلت عليها
  return result;
}
*/