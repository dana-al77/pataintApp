import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl; // رابط الصورة من السيرفر
  final File? imageFile; // الصورة الجديدة (إذا المستخدم اختار)
  final bool isEditing; // لتحديد ما إذا كنا في وضع التعديل
  final VoidCallback? onTap; // حدث الضغط على زر الكاميرا

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.isEditing = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. الهالة الزجاجية الخارجية
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
          ),

          // 2. الدائرة الزجاجية الوسطى (التأثير الأوضح)
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ],
            ),
          ),

          // 3. صورة البروفايل الفعلية (مع اللوجيك تبعك)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              // اللوجيك: إذا في ملف محلي نعرضه، وإلا نعرض الرابط
              image: imageFile != null
                  ? DecorationImage(
                image: FileImage(imageFile!),
                fit: BoxFit.cover,
              )
                  : (imageUrl != null && imageUrl!.isNotEmpty)
                  ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            // إذا مافي لا ملف ولا رابط، نعرض أيقونة افتراضية
            child: (imageFile == null && (imageUrl == null || imageUrl!.isEmpty))
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),

          // 4. زر الكاميرا (يظهر فقط إذا isEditing == true)
          if (isEditing)
            Positioned(
              bottom: 12, // رفعناه شوي ليجلس فوق الهالة الزجاجية بشكل أنيق
              right: 12,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: AppColor.secondyColor, // لون الأيقونة الخاص بك
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}