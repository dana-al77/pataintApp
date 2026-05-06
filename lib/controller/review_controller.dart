import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../data/datasource/remote/review_data.dart';

class ReviewController extends GetxController {

  StatusRequest statusRequest = StatusRequest.none;

  late ReviewData reviewData;

  int rating = 0;
  TextEditingController comment = TextEditingController();

  String? reviewId;

  /// ⭐ اختيار التقييم
  void setRating(int value) {
    rating = value;
    update();
  }

  /// ➕ إضافة تقييم
  addReview(String doctorId) async {

    if (rating == 0) {
      Get.snackbar("تنبيه", "اختر تقييم");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await reviewData.addReview(
      doctorId: doctorId,
      rating: rating.toString(),
      comment: comment.text,
    );
    print("RESPONSE TYPE: ${response.runtimeType}");
    print("RESPONSE: $response");
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {

        reviewId = response['data']['id'].toString();

        Get.snackbar("نجاح", "تم إضافة التقييم");

      } else {
        Get.snackbar(
          "خطأ",
          response['message'] is String
              ? response['message']
              : response['error'] ?? "حدث خطأ",
        );      }
    }

    update();
  }

  /// ✏️ تعديل التعليق
  updateReview() async {

    if (reviewId == null) return;

    statusRequest = StatusRequest.loading;
    update();

    var response = await reviewData.updateReview(
      reviewId: reviewId!,
      comment: comment.text,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        Get.snackbar("نجاح", "تم تعديل التعليق");
      }
    }

    update();
  }

  /// ❌ حذف
  deleteReview() async {

    if (reviewId == null) return;

    statusRequest = StatusRequest.loading;
    update();

    var response = await reviewData.deleteReview(
      reviewId: reviewId!,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {

        rating = 0;
        comment.clear();
        reviewId = null;

        Get.snackbar("تم", "تم حذف التقييم");
      }
    }

    update();
  }

  @override
  void onInit() {
    reviewData = ReviewData(Get.find());
    super.onInit();
  }
}