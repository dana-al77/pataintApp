import 'package:get/get.dart';

import '../../core/constant/routes.dart';

abstract class SucessSignUpController extends GetxController{

  goToPagrLogin();
}
class SucessSignUpControllerImp extends SucessSignUpController{
  @override
  goToPagrLogin() {
    Get.offAllNamed(AppRoute.login);
  }

}