import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class CompleteProfileData {
  Crud crud;

  CompleteProfileData(this.crud);

  postData({
    required String dateOfBirth,
    required String country,
    required String city,
    required String emergencyContact,
    required String gender,
    required String phone,
    File? imageFile,
  }) async {

    if (imageFile != null) {
      // 📷 مع صورة
      var response = await crud.postDataWithFileAndToken(
        AppLink.completeProfile,
        {
          "date_of_birth": dateOfBirth,
          "country": country,
          "city": city,
          "emergency_contact": emergencyContact,
          "gender": gender,
          "phone": phone,
        },
        imageFile,
        "profile_image", // 👈 مهم جداً
      );

      return response.fold((l) => l, (r) => r);

    } else {
      // 🧾 بدون صورة
      var response = await crud.PostDataWithToken(
        AppLink.completeProfile,
        {
          "date_of_birth": dateOfBirth,
          "country": country,
          "city": city,
          "emergency_contact": emergencyContact,
          "gender": gender,
          "phone": phone,
        },
      );

      return response.fold((l) => l, (r) => r);
    }
  }
}