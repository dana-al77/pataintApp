
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/medical_tips.dart';
import '../../data/model/medical_tip.dart';


abstract class ViewMedicalTipsController extends GetxController {
  getMedicalTips();


}

class ViewMedicalTipsControllerImp extends ViewMedicalTipsController {




  StatusRequest statusRequest=StatusRequest.none;

  MedicalTips medicalTips = MedicalTips(Get.find());

  List<MedicalTip> data = [];

  List<MedicalTip> getDummyTips() {
    return [
      MedicalTip(
        title: "اشرب الماء بانتظام",
        content: "حافظ على شرب 8 أكواب ماء يومياً لتحسين صحة الجسم.",
        createdBy: "طبيب عام",
      ),
      MedicalTip(
        title: "النوم الكافي",
        content: "النوم لمدة 7-8 ساعات يساعد على تحسين التركيز والصحة.",
        createdBy: "أخصائي نفسي",
      ),
      MedicalTip(
        title: "ممارسة الرياضة",
        content: "30 دقيقة يومياً من الرياضة تعزز صحة القلب.",
        createdBy: "مدرب صحي",
      ),
      MedicalTip(
        title: "تجنب التوتر",
        content: "حاول الاسترخاء وممارسة التأمل لتخفيف الضغط.",
        createdBy: "دكتور نفسي",
      ),
    ];
  }
  // @override
  // getMedicalTips() async {
  //
  //   data.clear();
  //   statusRequest = StatusRequest.loading;
  //   update();
  //
  //   var response = await medicalTips.get();
  //   print("==============================response $response");
  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['success'] == true) {
  //       List dataList =response['data'];
  //       for (var e in dataList) {
  //         print("🟡 Raw manager from API: $e");
  //       }
  //       data.addAll(dataList.map((e) => MedicalTip.fromJson(e)));
  //       print("valid");
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //
  //     }
  //   }
  //   update();
  // }
  //
  //

  @override
  getMedicalTips() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await medicalTips.get();
    print("==============================response $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true &&
          response['data'] != null &&
          response['data'].isNotEmpty) {

        List dataList = response['data'];
        data.addAll(dataList.map((e) => MedicalTip.fromJson(e)));

      } else {
        /// ❗ السيرفر شغال بس فاضي
        data = getDummyTips();
      }

    } else {
      /// ❗ السيرفر واقع
      data = getDummyTips();
    }

    update();
  }


  @override
  void onInit() {
    getMedicalTips();
    super.onInit();
  }



}
