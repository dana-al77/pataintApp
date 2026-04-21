import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';

void showCustomDialog({
  String? title,
  String? message,

  String? confirmText,
  String? cancelText,

  VoidCallback? onConfirm,
  VoidCallback? onCancel,

  IconData? icon,
  Color? iconColor,
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔵 الأيقونة (اختياري)
            if (icon != null)
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColor.thirdColor).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor ?? AppColor.thirdColor,
                ),
              ),

            if (icon != null) SizedBox(height: 15),

            /// 🟣 العنوان (اختياري)
            if (title != null)
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (title != null) SizedBox(height: 10),

            /// 🟡 الرسالة
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),

            SizedBox(height: 20),

            /// 🔘 الأزرار
            Row(
              children: [

                /// زر إلغاء (اختياري)
                if (cancelText != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                        if (onCancel != null) onCancel();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(cancelText),
                    ),
                  ),

                if (cancelText != null && confirmText != null)
                  SizedBox(width: 10),

                /// زر تأكيد
                if (confirmText != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        if (onConfirm != null) onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        confirmText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}