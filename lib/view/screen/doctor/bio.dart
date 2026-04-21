import 'package:flutter/material.dart';

class DoctorBio extends StatefulWidget {
  final String? bio;

  const DoctorBio({super.key, this.bio});

  @override
  State<DoctorBio> createState() => _DoctorBioState();
}

class _DoctorBioState extends State<DoctorBio> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.bio == null || widget.bio!.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 العنوان
          const Text(
            "نبذة عن الطبيب",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          /// 🔹 النص
          Text(
            widget.bio!,
            maxLines: isExpanded ? null : 2,
            overflow:
            isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),

          /// 🔹 زر عرض المزيد
          if (widget.bio!.length > 80)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  isExpanded ? "عرض أقل" : "عرض المزيد",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}