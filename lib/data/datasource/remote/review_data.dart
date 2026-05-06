import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ReviewData {
  Crud crud;

  ReviewData(this.crud);

  /// ➕ إضافة تقييم
  addReview({
    required String doctorId,
    required String rating,
    required String comment,
  }) async {
    var response = await crud.PostDataWithToken(
      AppLink.addReview,
      {
        "doctor_id": doctorId,
        "rating": rating,
        "comment": comment,
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  /// ✏️ تعديل التعليق
  updateReview({
    required String reviewId,
    required String comment,
  }) async {
    var response = await crud.PostDataWithToken(
      "${AppLink.updateReview}/$reviewId",
      {
        "comment": comment,
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  /// ❌ حذف
  deleteReview({
    required String reviewId,
  }) async {
    var response = await crud.PostDataWithToken(
      "${AppLink.deleteReview}/$reviewId",
      {},
    );

    return response.fold((l) => l, (r) => r);
  }
}