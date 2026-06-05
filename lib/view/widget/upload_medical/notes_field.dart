import 'package:flutter/material.dart';

class NotesInputField extends StatelessWidget {
  final TextEditingController controller;

  const NotesInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. عنوان القسم العلوي (Notes for Doctor) كما في الصورة تماماً
        const Text(
          "ملاحظات للطبيب",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1C24), // لون داكن مريح وعصري
          ),
        ),
        const SizedBox(height: 14),

        // 2. حاوية لتطبيق تصميم الخلفية والظل الناعم المطابق للصورة
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // خلفية بيضاء نقية
            borderRadius: BorderRadius.circular(24), // زوايا دائرية ناعمة وكبيرة متناسقة مع التصاميم السابقة
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03), // ظل خفيف جداً وغير مزعج للعين
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: 4, // يعطي مساحة مريحة للكتابة تطابق أبعاد الصورة
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1A1C24),
            ),
            decoration: InputDecoration(
              // نص التلميح الافتراضي (Hint Text)
              hintText: "أكتب ملاحظات لطبيبك...",
              hintStyle: const TextStyle(
                color: Color(0xFF9EA6B1), // لون رمادي ناعم جداً مطابق للصورة
                fontSize: 15,
              ),

              // إلغاء تفعيل الخلفية الملونة القديمة ليكون التصميم أبيض نقي
              filled: false,

              // إزالة كافة الحدود الافتراضية والاعتماد على تصميم الـ Container الخارجي ليعطي المظهر الانسيابي
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,

              // مسافات داخلية مريحة تعطي مرونة أثناء بدء وسير عملية الكتابة
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
        ),
      ],
    );
  }
}