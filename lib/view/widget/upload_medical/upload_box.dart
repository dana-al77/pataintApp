import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class MedicalAssetUploader extends StatelessWidget {
  final VoidCallback onTakePhotoPressed;
  final VoidCallback onChooseFilePressed;

  const MedicalAssetUploader({
    Key? key,
    required this.onTakePhotoPressed,
    required this.onChooseFilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تم استبدال DottedBorder بـ Container ذو حواف مستمرة أنيقة ومطابقة لأبعاد الصورة
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.secondyColor.withOpacity(0.02), // خلفية هادئة مائلة للبنفسجي
        borderRadius: BorderRadius.circular(24), // الزوايا الدائرية الكبيرة للمربع
        border: Border.all(
          color:AppColor.secondyColor.withOpacity(0.25), // لون الحواف الخارجي
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. أيقونة الرفع المتدرجة والأنيقة
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.secondyColor,
                  AppColor.blueColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5D5FEF).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: const Icon(
              Icons.upload_sharp,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // 2. النصوص التوضيحية
          const Text(
            "رفع ملفات الطبيب",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1C24),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "اسحب الملفات وأفلتها هنا",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 24),

          // 3. صف الأزرار التفاعلية
          Row(
            children: [
              // زر التقاط الصورة البنفسجي
              Expanded(
                child: InkWell(
                  onTap: onTakePhotoPressed,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColor.secondyColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "التقط صورة",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // زر اختيار ملف الأبيض
              Expanded(
                child: InkWell(
                  onTap: onChooseFilePressed,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.insert_drive_file_outlined, color: Color(0xFF1A1C24), size: 18),
                        SizedBox(width: 8),
                        Text(
                          "اختر ملف",
                          style: TextStyle(
                            color: Color(0xFF1A1C24),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4. مؤشر الأمان والحماية في الأسفل
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield_outlined, color: Colors.red, size: 16),
              const SizedBox(width: 6),
               Text(
                "تشفير آمن وحماية كاملة",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
//                    alignment: Alignment.center
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}