import 'package:get/get.dart';

import '../controller/notification_controller.dart';
import '../core/class/crud.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {

  Get.put(Crud());
  Get.put(NotificationController(), permanent: true);
    }

}