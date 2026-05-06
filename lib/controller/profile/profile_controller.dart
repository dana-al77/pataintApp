import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/profile/profile_data.dart';
import '../../data/model/profile/pateint_model.dart';
import '../../data/model/profile/profile_model.dart';

class ProfileController extends GetxController {
  ProfileData profileData = ProfileData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  ProfileModel? profileModel;

  //
  // getProfile() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //
  //   var response = await profileData.getData();
  //
  //   print("===== PROFILE RESPONSE $response");
  //
  //   statusRequest = handlingData(response);
  //
  //   if (statusRequest == StatusRequest.success) {
  //     if (response['success'] == true) {
  //       profileModel = ProfileModel.fromJson(response['data']);
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //
  //   update();
  // }

  getProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await profileData.getData();

    print("===== PROFILE RESPONSE $response");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response is Map &&
        response['success'] == true) {
      profileModel = ProfileModel.fromJson(response['data']);

    } else {
      // 💥 أي فشل = اعرض mock
      _loadMockData();

      // ⭐ أهم سطر في المشروع كله
      statusRequest = StatusRequest.success;
    }

    update();
  }
  updateProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await profileData.updateData({
      "date_of_birth": profileModel?.patient?.dateOfBirth,
      "country": profileModel?.patient?.country,
      "city": profileModel?.patient?.city,
      "emergency_contact": profileModel?.patient?.emergencyContact,
    });

    print("===== UPDATE RESPONSE $response");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        /// 🔥 تحديث المودل بعد التعديل
        profileModel = ProfileModel.fromJson(response['data']);

        Get.snackbar("Success", "Profile updated");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
  void _loadMockData() {
    profileModel = ProfileModel(
      id: 1,
      name: "ماريتا الاححمد",
      email: "materahvhs45.com",
      status: "active",
      role: "patient",
      profileImage: "",
      phone: "+963 987 234 678",
      patient: PatientModel(
        dateOfBirth: "1998-01-01",
        country: "ريف دمشق",
        city: "القاببون",
        emergencyContact: "+963 968 915 157",
      ),
    );

    print("⚠️ Loaded MOCK DATA (server is OFF)");
  }
  @override
  void onInit() {
    getProfile(); // 👈 أول ما تفتح الصفحة
    super.onInit();
  }
}