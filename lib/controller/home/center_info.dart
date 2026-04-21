import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/center_info_data.dart';
import '../../data/model/center_info.dart';

abstract class ViewCenetrInfoController extends GetxController {
  getCenterInfo();
}

class ViewCenetrInfoControllerImp extends ViewCenetrInfoController {

  StatusRequest statusRequest = StatusRequest.none;
  CenterInfoData centerInfoData = CenterInfoData(Get.find());
  List<CenterInfo> data = [];
  List<CenterInfo> getDummyData() {
    return [
      CenterInfo(
        location: "مركز الشفاء الطبي",
        openingHours: "من 8 صباحاً حتى 10 مساءً",
        addressOnMap: "دمشق - شارع الثورة",
        branches: "فرع المزة - فرع البرامكة",
        services: "طب عام - أطفال - نسائية",
      ),
      // CenterInfo(
      //   location: "مركز الحياة",
      //   openingHours: "24 ساعة",
      //   addressOnMap: "حلب - الفرقان",
      //   branches: "فرع رئيسي",
      //   services: "إسعاف - مخابر - أشعة",
      // ),
    ];
  }
  // @override
  // getCenterInfo() async {
  //   data.clear();
  //   statusRequest = StatusRequest.loading;
  //   update();
  //
  //   var response = await centerInfoData.get();
  //   print("==============================response $response");
  //
  //   statusRequest = handlingData(response);
  //
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['success'] == true) {
  //       List dataList = response['data'];
  //       for (var e in dataList) {
  //         print("🟡 Raw branch from API: $e");
  //       }
  //       data.addAll(dataList.map((e) => CenterInfo.fromJson(e)));
  //       print("valid");
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //   update();
  // }
  @override
  getCenterInfo() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await centerInfoData.get();
    print("==============================response $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true && response['data'] != null && response['data'].isNotEmpty) {

        List dataList = response['data'];
        data.addAll(dataList.map((e) => CenterInfo.fromJson(e)));

      } else {
        /// ❗ السيرفر شغال بس ما في بيانات
        data = getDummyData();
      }

    } else {
      /// ❗ السيرفر واقع
      data = getDummyData();
    }

    update();
  }
  @override
  void onInit() {
    getCenterInfo();
    super.onInit();
  }
}