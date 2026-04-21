import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/appiontement/first_appion_controller.dart';
import '../../../core/constant/color.dart';
// class ChipsField extends GetView<FistAppiontController> {
//   final String title;
//   final TextEditingController textController;
//   final List<String> options;
//
//   const ChipsField({
//     super.key,
//     required this.title,
//     required this.textController,
//     required this.options,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> selected =
//     textController.text.isEmpty ? [] : textController.text.split(',');
//
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 20)),
//
//           Wrap(
//             spacing: 10,
//             children: options.map((e) {
//               final isSelected = selected.contains(e);
//
//               return ChoiceChip(
//                 label: Text(e),
//                 selected: isSelected,
//                 onSelected: (_) => toggleValue(e, selected),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void toggleValue(String value, List<String> selected) {
//     if (selected.contains(value)) {
//       selected.remove(value);
//     } else {
//       selected.add(value);
//     }
//
//     textController.text = selected.join(',');
//     controller.update();
//   }
// }
class ChipsField extends GetView<FistAppiontController> {
  final String title;
  final IconData icon;
  final Color iconColor;
  final TextEditingController textController;
  final List<String> options;

  const ChipsField({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.textController,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    // تحويل النص المخزن في Controller إلى قائمة للتحقق من الاختيار
    List<String> selected = textController.text.isEmpty ? [] : textController.text.split(',');

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس القسم: الأيقونة والعنوان
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // عرض الخيارات بشكل مرن
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: options.map((e) {
              final isSelected = selected.contains(e);

              return GestureDetector(
                onTap: () => toggleValue(e, selected),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  //   // تطبيق التدرج اللوني الأزرق عند الاختيار
                  //   gradient: isSelected
                  //       ? const LinearGradient(
                  //    // colors: [Color(0xFF00B4D8), Color(0xFF0077B6)],
                  //   colors: AppColor.serviceGradient,
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //   )
                  //       : null,
                  //   color: isSelected ? null : const Color(0xFFF1F3F5),
                  //   boxShadow: isSelected
                  //       ? [
                  //     BoxShadow(
                  //       color: const Color(0xFF00B4D8).withOpacity(0.3),
                  //       blurRadius: 6,
                  //       offset: const Offset(0, 3),
                  //     )
                  //   ]
                  //       : [],
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                    color: isSelected
                        ? AppColor.secondyColor // 👈 لون واحد عند الاختيار
                        : const Color(0xFFF1F3F5),

                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColor.secondyColor.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]
                        : [],
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void toggleValue(String value, List<String> selected) {
    if (selected.contains(value)) {
      selected.remove(value);
    } else {
      selected.add(value);
    }
    textController.text = selected.join(',');
    controller.update(); // تحديث الواجهة عبر GetX
  }
}