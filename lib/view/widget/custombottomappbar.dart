import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool? active;

  const CustomButtonAppBar({
    super.key,
    required this.textbutton,
    required this.icondata,
    required this.onPressed,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔥 نخفي الأيقونة إذا كانت active
            if (active != true)
              Icon(
                icondata,
                size: 25,
                color: AppColor.grey,
              ),

            const SizedBox(height: 4),

            // 🔤 النص
            Text(
              textbutton,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: active == true
                    ? AppColor.secondyColor
                    : AppColor.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}