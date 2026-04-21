import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final bool isSearching;

  const CustomSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          elevation: 5,
          shadowColor: AppColor.backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.white,
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 15, color: AppColor.grey),

              prefixIcon: const Icon(Icons.search, color: AppColor.grey),

              // ✅ زر المسح
              suffixIcon: isSearching
                  ? IconButton(
                icon: const Icon(Icons.clear, color: AppColor.thirdColor),
                onPressed: onClear,
              )
                  : null,

              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                BorderSide(color: Colors.blue.shade100.withOpacity(0.5)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: AppColor.thirdColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}