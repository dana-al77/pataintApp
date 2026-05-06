import 'package:flutter/material.dart';
import '../../controller/review_controller.dart';
import 'package:get/get.dart';

class ReviewDialog extends StatelessWidget {
  final String doctorId;

  const ReviewDialog({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    Get.put(ReviewController());

    return GetBuilder<ReviewController>(
      builder: (controller) => AlertDialog(
        title: const Text("قيّم الطبيب"),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ⭐ Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => controller.setRating(index + 1),
                  icon: Icon(
                    Icons.star,
                    color: controller.rating > index
                        ? Colors.amber
                        : Colors.grey,
                  ),
                );
              }),
            ),

            /// 💬 Comment
            TextField(
              controller: controller.comment,
              decoration: const InputDecoration(
                hintText: "اكتب تعليقك...",
              ),
            ),
          ],
        ),

        actions: [

          TextButton(
            onPressed: () => controller.deleteReview(),
            child: const Text("حذف"),
          ),

          TextButton(
            onPressed: () => controller.updateReview(),
            child: const Text("تعديل"),
          ),

          ElevatedButton(
            onPressed: () => controller.addReview(doctorId),
            child: const Text("إرسال"),
          ),
        ],
      ),
    );
  }
}