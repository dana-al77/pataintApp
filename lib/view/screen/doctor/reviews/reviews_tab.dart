import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/review_controller.dart';
import '../../../../../core/constant/color.dart';
import '../../../../../core/functions/format.dart';
import 'add_review_dialog.dart';

class ReviewsTab extends StatefulWidget {

  final String doctorId;

  const ReviewsTab({
    super.key,
    required this.doctorId,
  });

  @override
  State<ReviewsTab> createState() =>
      _ReviewsTabState();
}

class _ReviewsTabState
    extends State<ReviewsTab> {

  late ReviewController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<ReviewController>();
    /// 🔥 الحل هون
    WidgetsBinding.instance.addPostFrameCallback((_) {

      controller.getReviews(
        widget.doctorId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        const SizedBox(height: 10),

        /// 🔥 HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Row(
            children: [

              const Text(
                "أحدث التقييمات",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const Spacer(),

            ],
          ),
        ),


        /// 📦 REVIEWS
        Expanded(
          child: GetBuilder<ReviewController>(
            builder: (ctrl) {

              if (ctrl.reviews.isEmpty) {

                return Center(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      /// ⭐ ICON
                      Container(

                        width: 90,
                        height: 90,

                        decoration: BoxDecoration(
                          color: AppColor.secondyColor.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.rate_review_rounded,
                          size: 42,
                          color: AppColor.secondyColor,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// 📝 TITLE
                      const Text(
                        "لا يوجد تقييمات حتى الآن",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 💬 SUBTITLE
                      Text(
                        "كن أول شخص يشارك تجربته مع الطبيب",

                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      /// 🔥 BUTTON
                      GestureDetector(

                        onTap: () {

                          controller.reviewId = null;

                          controller.comment.clear();

                          controller.rating = 0;

                          showReviewDialog(
                            doctorId: widget.doctorId,
                          );
                        },

                        child: Container(

                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 14,
                          ),

                          decoration: BoxDecoration(

                            gradient: LinearGradient(
                              colors: [
                                AppColor.blueColor,
                                AppColor.secondyColor,
                              ],
                            ),

                            borderRadius: BorderRadius.circular(18),

                            boxShadow: [

                              BoxShadow(
                                color:
                                AppColor.secondyColor.withOpacity(0.25),

                                blurRadius: 14,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: const Text(
                            "إضافة أول تقييم",

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(

                itemCount: ctrl.reviews.length,

                itemBuilder: (context, index) {

                  final review = ctrl.reviews[index];
                  print(controller.currentUserId);
                  print(review.patientId);
                  return Container(

                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// HEADER
                        Row(
                          children: [

                            CircleAvatar(
                              radius: 22,

                              backgroundImage:
                              review.patient?.profileImage != null
                                  ? NetworkImage(
                                review.patient!.profileImage!,
                              )
                                  : null,

                              child: review.patient?.profileImage == null
                                  ? Text(
                                review.patient?.name[0] ?? "",
                              )
                                  : null,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    review.patient?.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    formatDate(review.createAt),

                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (controller.currentUserId ==
                                review.patientId.toString())

                              PopupMenuButton(

                                icon: const Icon(
                                  Icons.more_vert,
                                ),

                                itemBuilder: (context) => [

                                  const PopupMenuItem(
                                    value: "edit",
                                    child: Text("تعديل"),
                                  ),

                                  const PopupMenuItem(
                                    value: "delete",
                                    child: Text("حذف"),
                                  ),
                                ],

                                onSelected: (value) async {

                                  /// ✏️ تعديل
                                  if (value == "edit") {

                                    controller.reviewId =
                                        review.id.toString();

                                    controller.comment.text =
                                        review.comment ?? "";

                                    controller.rating =
                                        review.rating;

                                    showReviewDialog(
                                      doctorId: widget.doctorId,
                                    );
                                  }

                                  /// ❌ حذف
                                  if (value == "delete") {

                                    controller.reviewId =
                                        review.id.toString();

                                    await controller.deleteReview();

                                    await controller.getReviews(
                                      widget.doctorId,
                                    );
                                  }
                                },
                              ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// ⭐ STARS
                        Row(
                          children: List.generate(
                            review.rating,

                                (i) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// 💬 COMMENT
                        Text(
                          review.comment ?? "لا يوجد تعليق",

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// FOOTER
                        Row(
                          children: [

                            // GestureDetector(
                            //
                            //   onTap: () {
                            //
                            //     controller.toggleLike(
                            //       review.id.toString(),
                            //     );
                            //   },
                            //
                            //   child: Row(
                            //     children: [
                            //
                            //       Icon(
                            //         review.isLiked
                            //             ? Icons.thumb_up
                            //             : Icons.thumb_up_alt_outlined,
                            //
                            //         size: 18,
                            //
                            //         color: review.isLiked
                            //             ? Colors.blue
                            //             : Colors.grey.shade600,
                            //       ),
                            //
                            //       const SizedBox(width: 4),
                            //
                            //       Text(
                            //         review.likesCount.toString(),
                            //
                            //         style: TextStyle(
                            //           color: review.isLiked
                            //               ? Colors.blue
                            //               : Colors.grey.shade600,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            // const Spacer(),
                            //
                            // Text(
                            //   "رد الدكتور",
                            //
                            //   style: TextStyle(
                            //     color: AppColor.secondyColor,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}