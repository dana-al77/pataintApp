import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/color.dart';

class DoctorInfoRow extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color iconColor;

  const DoctorInfoRow({
    super.key,
     this.icon,
    required this.text,
    this.iconColor = AppColor.inactiveDotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 14.sp,
        ),
        SizedBox(width: 3.w),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}