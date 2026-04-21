// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//
//   const CustomTextField({super.key, required this.label, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
  });

  void _updateValue(bool isIncrement) {
    double currentValue = double.tryParse(controller.text) ?? 0;
    if (isIncrement) {
      currentValue++;
    } else {
      if (currentValue > 0) currentValue--;
    }
    // إزالة الأصفار الزائدة عند العرض
    controller.text = currentValue % 1 == 0
        ? currentValue.toInt().toString()
        : currentValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF37474F)),
          ),
          const SizedBox(height: 10),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => _updateValue(true),
                      child: const Icon(Icons.arrow_drop_up_outlined, size: 20, ),
                    ),
                    InkWell(
                      onTap: () => _updateValue(false),
                      child: const Icon(Icons.arrow_drop_down_outlined, size: 20,),
                    ),
                  ],
                ),
                const SizedBox(width:12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}