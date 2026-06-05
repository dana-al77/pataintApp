import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';

class AnalysisTypeSelector extends StatelessWidget {
  // تمرير الـ Controller الخاص بكِ ليكون الكلاس ديناميكي
  final dynamic controller;

  // القائمة النصية للخيارات المتاحة مع الرموز التعبيرية المطابقة للصورة
  final List<Map<String, String>> analysisTypes = const [
    {'name': 'Blood Test', 'icon': '🩸'},
    {'name': 'X-Ray', 'icon': '🦴'},
    {'name': 'MRI', 'icon': '🧠'},
  ];

  const AnalysisTypeSelector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان القسم العلوي (Analysis Type)
        const Text(
          "نوع التحليل",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1C24),
          ),
        ),
        const SizedBox(height: 14),

        // قائمة العناصر الأفقية القابلة للاختيار
        SizedBox(
          height: 55, // ارتفاع الأزرار المطابق للصورة تماماً
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: analysisTypes.length,
            itemBuilder: (context, index) {
              final item = analysisTypes[index];
              final String typeName = item['name']!;
              final String typeIcon = item['icon']!;

              // استخدام Obx لضمان تحديث الواجهة فوراً عند تغيير الاختيار
              return Obx(() {
                final bool isSelected = controller.selectedAnalysisType.value == typeName;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => controller.changeAnalysisType(typeName),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200), // أنيميشن ناعم جداً عند التنقل
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        // التدرج الماسي الفخم المعتمد (0xFF408BCF) في حال تم الاختيار
                        gradient: isSelected
                            ? const LinearGradient(
                          colors: [
                            AppColor.secondyColor,
                            AppColor.blueColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        color: isSelected ? null : Colors.white, // خلفية بيضاء نقية للعناصر غير النشطة
                        border: isSelected
                            ? null
                            : Border.all(
                          color: Colors.black12.withOpacity(0.06),
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: const Color(0xFF408BCF).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ]
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // الأيقونة أو الرمز التعبيري
                          Text(
                            typeIcon,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          // اسم نوع التحليل
                          Text(
                            typeName,
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF1A1C24),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}