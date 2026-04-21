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
  }) async {
    var response = await crud.PostDataWithToken(AppLink.completeProfile, {
      "date_of_birth": dateOfBirth,
      "country": country,
      "city": city,
      "emergency_contact": emergencyContact,
      "gender": gender,
      "phone": phone,
    });

    return response.fold((l) => l, (r) => r);
  }
}