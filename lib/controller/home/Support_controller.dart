import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/Support_data.dart';
import '../../data/datasource/remote/medical_tips.dart';
import '../../data/model/medical_tip.dart';
import '../../data/model/support_model.dart';


abstract class SupportController extends GetxController {
  getPsychSupport();


}

class SupportControllerImp extends SupportController {




  StatusRequest statusRequest=StatusRequest.none;

  SupportData supportData = SupportData(Get.find());

  List<SupportModel> data = [];
  // 👇 داتا وهمية مؤقتة
  final dummyData = [
    {
      "title": "التعامل مع القلق",
      "content": "خذ نفس عميق وابتعد عن مصادر التوتر لفترة قصيرة.",
      "image": "https://images.unsplash.com/photo-1493836512294-502baa1986e2"
    },
    {
      "title": "تحسين المزاج",
      "content": "مارس المشي يومياً لمدة 20 دقيقة.",
      "image": "https://images.unsplash.com/photo-1506126613408-eca07ce68773"
    },
    {
      "title": "نوم أفضل",
      "content": "تجنب الهاتف قبل النوم بساعة.",
      "image": "https://images.unsplash.com/photo-1517841905240-472988babdf9"
    },

  ];

  @override
  getPsychSupport() async {

    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await supportData.get();
    print("==============================response $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        List dataList =response['data'];
        for (var e in dataList) {
          print("🟡 Raw manager from API: $e");
        }
        data.addAll(dataList.map((e) => SupportModel.fromJson(e)));
        print("valid");
      } else {
        //statusRequest = StatusRequest.failure;
        dummyData;
      }
    }
    update();
  }






  @override
  void onInit() {
    getPsychSupport();
    super.onInit();
  }


// myback(){
//   Get.offAllNamed(AppRoute.Dashboard);
// return Future.value(false);
// }

}
