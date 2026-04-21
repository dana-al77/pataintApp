import 'package:flutter/material.dart';
class ReviewCard extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final List<ReviewItem> items;
  final bool isGrid; // معامل جديد للتمييز بين الطريقتين
  final Color? accentColor;

  const ReviewCard({
    super.key,
    required this.title,
    required this.onEdit,
    required this.items,
    this.isGrid = false, // القيمة الافتراضية هي Chips
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3E50))),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFF00B4D8).withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF00B4D8)),
                ),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 0.5),

          ...items.map((item) {
            if (isGrid) {
              // --- الطريقة الأولى: عرض نص بجانب العنوان (للمعلومات الأساسية) ---
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    Text(item.values.first, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              );
            } else {
              // --- الطريقة الثانية: عرض Chips ملونة (للحالة الصحية) ---
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.values.map((val) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (item.customColor ?? accentColor ?? Colors.cyan).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(val, style: TextStyle(color: item.customColor ?? accentColor ?? Colors.cyan, fontWeight: FontWeight.bold, fontSize: 12)),
                      )).toList(),
                    ),
                  ],
                ),
              );
            }
          }).toList(),
        ],
      ),
    );
  }
}

// تعديل كلاس الـ Item ليقبل قائمة نصوص (Values) ولون مخصص
class ReviewItem {
  final String label;
  final List<String> values; // قائمة بالخيارات المختارة
  final Color? customColor; // لون اختياري لهذا العنصر تحديداً

  ReviewItem({required this.label, required this.values, this.customColor});
}