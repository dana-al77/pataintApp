import 'package:flutter/material.dart';

class EditableRowTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController? controller;
  final Widget? trailing;

  const EditableRowTile({
    super.key,
    required this.icon,
    required this.title,
    this.controller,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: Icon(icon, size: 18),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),

              const SizedBox(height: 4),

              controller != null
                  ? TextField(
                controller: controller,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              )
                  : (trailing ?? const SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}