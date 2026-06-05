import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/review_data.dart';
import '../data/model/review_model.dart';

class ReviewController extends GetxController {

  StatusRequest statusRequest = StatusRequest.none;

  late ReviewData reviewData;
  final myServices = Get.find<MyServices>();
  String? currentUserId;

  int rating = 0;
  TextEditingController comment = TextEditingController();
  String? doctorId;
  String? reviewId;
  /// ⭐ اختيار التقييم
  void setRating(int value) {
    rating = value;
    update();
  }
  List<ReviewModel> reviews = [];
  double averageRating = 0.0;

  int totalReviews = 0;

  getReviews(String doctorId) async {

    statusRequest = StatusRequest.loading;
    update();

    var response = await reviewData.getReviews(doctorId);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {

      if (response['success'] == true) {

        /// ⭐ average rating
        averageRating = double.parse(
          response['data']['average_rating'].toString(),
        );

        /// ⭐ total reviews
        totalReviews = response['data']['total_reviews'];

        /// ⭐ تحويل JSON -> Model
        reviews = List<ReviewModel>.from(
          response['data']['reviews'].map(
                (e) => ReviewModel.fromJson(e),
          ),
        );
      }
    }

    update();
  }
  /// ➕ إضافة تقييم
  /// ➕ إضافة تقييم
  Future<bool> addReview(String doctorId) async {

    if (rating == 0) {
      Get.snackbar("تنبيه", "اختر تقييم");
      return false;
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


        Get.snackbar("نجاح", "تم إضافة التقييم");

        update();

        return true;
      }

      else {

        Get.snackbar(
          "خطأ",
          response['message'] is String
              ? response['message']
              : response['error'] ?? "حدث خطأ",
        );

        update();

        return false;
      }
    }

    update();

    return false;
  }

  /// ✏️ تعديل التعليق
  Future<bool> updateReview() async {

    if (reviewId == null) return false;

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

        reviewId = null;
        rating = 0;
        comment.clear();

        update();

        return true;
      }
    }

    update();

    return false;
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
    currentUserId =
        myServices.sharedPreferences
            .getString("id");
    super.onInit();
  }
}