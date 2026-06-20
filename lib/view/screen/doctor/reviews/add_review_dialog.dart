import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/review_controller.dart';
import '../../../../../core/constant/color.dart';

void showReviewDialog({
  required String doctorId,
}) {

  final ReviewController ctrl =
  Get.find<ReviewController>();

  Get.dialog(

    Dialog(

      backgroundColor: Colors.transparent,
      elevation: 0,

      child: Container(

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(32),

          boxShadow: [

            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: SingleChildScrollView(

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              /// ⭐ ICON
              Container(

                width: 70,
                height: 70,

                decoration: BoxDecoration(
                  color: AppColor.secondyColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.star_rounded,
                  color: AppColor.secondyColor,
                  size: 38,
                ),
              ),

              const SizedBox(height: 18),

              /// 📝 TITLE
              const Text(
                "أضف تقييمك",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "شارك تجربتك مع الطبيب",

                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 26),

              /// ⭐ STARS
              GetBuilder<ReviewController>(
                builder: (_) {
                  print("🔥 DIALOG REBUILD");
                  return Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: List.generate(5, (index) {

                      final selected =
                          index < ctrl.rating;

                      return GestureDetector(

                        onTap: () {
                          ctrl.setRating(index + 1);
                        },

                        child: AnimatedContainer(

                          duration:
                          const Duration(milliseconds: 200),

                          margin:
                          const EdgeInsets.symmetric(horizontal: 4),

                          child: Icon(
                            selected
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,

                            color: selected
                                ? Colors.amber
                                : Colors.grey.shade400,

                            size: selected ? 38 : 34,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// 💬 COMMENT FIELD
              Container(

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: TextField(

                  controller: ctrl.comment,

                  maxLines: 4,

                  decoration: InputDecoration(

                    hintText:
                    "اكتب تعليقك...",

                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                    const EdgeInsets.all(18),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              /// 🔥 BUTTONS
              Row(
                children: [

                  /// CANCEL
                  Expanded(
                    child: OutlinedButton(

                      style: OutlinedButton.styleFrom(

                        minimumSize:
                        const Size(double.infinity, 55),

                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {
                        Get.back();
                      },

                      child: const Text(
                        "إلغاء",

                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// SEND
                  Expanded(
                    child: Container(

                      height: 55,

                      decoration: BoxDecoration(

                        gradient: LinearGradient(
                          colors: [
                            AppColor.secondyColor,
                            AppColor.secondyColor
                                .withOpacity(0.8),
                          ],
                        ),

                        borderRadius:
                        BorderRadius.circular(18),

                        boxShadow: [

                          BoxShadow(
                            color: AppColor.secondyColor
                                .withOpacity(0.25),

                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Material(
                        color: Colors.transparent,

                        child: InkWell(

                          borderRadius:
                          BorderRadius.circular(18),

                          onTap: () async {

                            bool success = false;

                            /// ✏️ تعديل
                            if (ctrl.reviewId != null) {

                              success =
                              await ctrl.updateReview();
                            }

                            /// ➕ إضافة
                            else {

                              success =
                              await ctrl.addReview(doctorId);
                            }
                            print("SUCCESS = $success");
                            if (success) {

                              Get.back();

                              await Future.delayed(
                                const Duration(milliseconds: 200),
                              );

                              await ctrl.getReviews(doctorId);

                              ctrl.reviewId = null;
                              ctrl.rating = 0;
                              ctrl.comment.clear();
                            }
                          },

                          child: const Center(

                            child: Text(
                              "إرسال",

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}