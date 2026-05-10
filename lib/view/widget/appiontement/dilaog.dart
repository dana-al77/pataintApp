import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomConfirmDialog({
  required String title,
  required String message,
  IconData icon = Icons.info_outline,
  Color iconColor = Colors.blue,
  String confirmBtnText = "تأكيد",
  String cancelBtnText = "تراجع",
  required VoidCallback onConfirm, // الدالة اللي رح تتنفذ عند الضغط على زر التأكيد
  bool isActionDialog = true,      // لو false بيظهر بس زر واحد (للتنبيه العادي)
}) {
  Get.dialog(
    Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      // زر التراجع: يظهر فقط إذا كان الديالوج يتطلب إجراء (Action)
                      if (isActionDialog)
                        Expanded(
                          child: TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              cancelBtnText,
                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                      // زر التأكيد: يأخذ لون الأيقونة ليكون متناسقاً بصرياً
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: iconColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Get.back(); // إغلاق الديالوج أولاً
                            onConfirm(); // تنفيذ الأمر
                          },
                          child: Text(
                            confirmBtnText,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // الأيقونة العائمة بتصميم فخم
            Positioned(
              top: -40,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: iconColor.withOpacity(0.1),
                  child: Icon(icon, size: 40, color: iconColor),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false, // يمنع إغلاق الديالوج عند الضغط خارج الإطار (أكثر أماناً للإلغاء)
  );
}