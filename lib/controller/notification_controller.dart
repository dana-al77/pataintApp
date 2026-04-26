import 'package:get/get.dart';

import 'package:get/get.dart';

class NotificationController extends GetxController {
  int unreadCount = 0;

  List<Map<String, String>> notifications = [];

  void increment() {
    unreadCount++;
    update();
  }

  void reset() {
    unreadCount = 0;
    update();
  }

  // 🔥 إضافة إشعار جديد
  void addNotification(String title, String body) {
    notifications.insert(0, {
      "title": title,
      "body": body,
    });

    increment();
    update();
  }
}