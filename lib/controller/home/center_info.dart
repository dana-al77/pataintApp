import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  String getCurrentArabicDay() {
    String englishDay = DateFormat('EEEE').format(DateTime.now()); // بيجيب مثلاً "Saturday"

    Map<String, String> daysTranslation = {
      'Monday': 'الإثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
      'Sunday': 'الأحد',
    };

    return daysTranslation[englishDay] ?? "";
  }

  List<CenterInfo> getDummyData() {
    return [
      CenterInfo(
        location: "مركز الشفاء الطبي",
        openingHours: {
          "السبت": "08:00 ص - 10:00 م",
          "الأحد": "08:00 ص - 10:00 م",
          "الإثنين": "08:00 ص - 10:00 م",
          "الثلاثاء": "08:00 ص - 10:00 م",
          "الأربعاء": "08:00 ص - 10:00 م",
          "الخميس": "08:00 ص - 08:00 م",
          "الجمعة": "مغلق",
        },
        addressOnMap: "دمشق - شارع الثورة",
        branches: "فرع المزة - فرع البرامكة",
        services: "طب عام - مختبر - نسائية-تحاليل-ايكو-تخطيط قلب-أشعة",
      ),

    ];
  }

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