import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  final double radius;
  final EdgeInsets? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.radius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColor.secondyColor,
        foregroundColor: textColor ?? Colors.white,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: icon != null
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(text),
        ],
      )
          : Text(text),
    );
  }
}