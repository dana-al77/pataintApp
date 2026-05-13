import 'package:flutter/material.dart';
import 'package:patientapp/view/widget/qr/qr_action_button.dart';


class ActionButtonsRow extends StatelessWidget {
  final IconData firstIcon;
  final String firstTitle;
  final VoidCallback firstTap;

  final IconData secondIcon;
  final String secondTitle;
  final VoidCallback secondTap;

  const ActionButtonsRow({
    required this.firstIcon,
    required this.firstTitle,
    required this.firstTap,
    required this.secondIcon,
    required this.secondTitle,
    required this.secondTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: Row(
        children: [

          Expanded(
            child: ActionButton(
              icon: firstIcon,
              title: firstTitle,
              onTap: firstTap,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ActionButton(
              icon: secondIcon,
              title: secondTitle,
              onTap: secondTap,
            ),
          ),
        ],
      ),
    );
  }
}