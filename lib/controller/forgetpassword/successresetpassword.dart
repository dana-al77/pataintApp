import 'package:get/get.dart';

import '../../core/constant/routes.dart';

abstract class SuccessResetPasswordController extends GetxController{

  goToPagrLogin();
}
class SuccessResetPasswordControllerImp extends SuccessResetPasswordController{
  @override
  goToPagrLogin() {
   Get.offAllNamed(AppRoute.login);
  }

}