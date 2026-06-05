import 'dart:convert';

import 'package:get/get.dart';

import '../core/services/services.dart';

class NotificationController extends GetxController {
  final MyServices myServices = Get.find();

  int unreadCount = 0;

  bool isNotificationScreenOpen = false;

  List<Map<String, String>> notifications = [];

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void increment() {
    unreadCount++;
    update();
  }

  void reset() {
    unreadCount = 0;
    update();
  }

  void addNotification(String title, String body) {
    notifications.insert(0, {
      "title": title,
      "body": body,
    });

    saveNotifications();

    if (!isNotificationScreenOpen) {
      increment();
    }

    update();
  }

  void saveNotifications() {
    String data = jsonEncode(notifications);

    myServices.sharedPreferences
        .setString('notifications', data);
  }

  void loadNotifications() {
    String? data =
    myServices.sharedPreferences.getString('notifications');

    if (data != null) {
      List decoded = jsonDecode(data);

      notifications =
          decoded.map((e) => Map<String, String>.from(e)).toList();

      update();
    }
  }
}


// import 'package:get/get.dart';
//
// import 'package:get/get.dart';
//
// class NotificationController extends GetxController {
//   int unreadCount = 0;
//   bool isNotificationScreenOpen = false;
//   List<Map<String, String>> notifications = [];
//
//   void increment() {
//     unreadCount++;
//     update();
//   }
//
//   void reset() {
//     unreadCount = 0;
//     update();
//   }
//
//   // 🔥 إضافة إشعار جديد
//   // void addNotification(String title, String body) {
//   //   notifications.insert(0, {
//   //     "title": title,
//   //     "body": body,
//   //   });
//   //
//   //   increment();
//   //   update();
//   // }
//   void addNotification(String title, String body) {
//     notifications.insert(0, {
//       "title": title,
//       "body": body,
//     });
//
//     if (!isNotificationScreenOpen) {
//       increment();
//     }
//
//     update();
//   }
// }