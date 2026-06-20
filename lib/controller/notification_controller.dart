import 'dart:convert';

import 'package:flutter/material.dart';
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

  // void addNotification(String title, String body) {
  //   notifications.insert(0, {
  //     "title": title,
  //     "body": body,
  //   });
  //
  //   saveNotifications();
  //
  //   if (!isNotificationScreenOpen) {
  //     increment();
  //   }
  //
  //   update();
  // }
  Color getNotificationColor(String? type) {
    switch (type) {
      case 'support':
        return Colors.blue;

      case 'psychological_support':
        return Colors.pink;

      case 'alert':
        return Colors.red;

      case 'reminder':
        return Colors.orange;

      case 'appointment':
        return Colors.green;

      default:
        return const Color(0xff1EB980);
    }
  }

  Color getNotificationBackgroundColor(String? type) {
    switch (type) {
      case 'support':
        return Colors.blue.withOpacity(0.12);

      case 'psychological_support':
        return Colors.pink.withOpacity(0.12);

      case 'alert':
        return Colors.red.withOpacity(0.12);

      case 'reminder':
        return Colors.orange.withOpacity(0.12);

      case 'appointment':
        return Colors.green.withOpacity(0.12);

      default:
        return const Color(0xffE8F7F5);
    }
  }
  String getTimeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final difference = DateTime.now().difference(date);

      if (difference.inSeconds < 60) {
        return "الآن";
      }

      if (difference.inMinutes < 60) {
        return difference.inMinutes == 1
            ? "منذ دقيقة"
            : "منذ ${difference.inMinutes} دقائق";
      }

      if (difference.inHours < 24) {
        return difference.inHours == 1
            ? "منذ ساعة"
            : "منذ ${difference.inHours} ساعات";
      }

      if (difference.inDays < 30) {
        return difference.inDays == 1
            ? "منذ يوم"
            : "منذ ${difference.inDays} أيام";
      }

      if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1
            ? "منذ شهر"
            : "منذ $months أشهر";
      }

      final years = (difference.inDays / 365).floor();
      return years == 1
          ? "منذ سنة"
          : "منذ $years سنوات";
    } catch (e) {
      return "";
    }
  }
  IconData getNotificationIcon(String? type) {
    switch (type) {

      case 'support':
        return Icons.support_agent_rounded;

      case 'psychological_support':
        return Icons.favorite_rounded;

      case 'alert':
        return Icons.warning_amber_rounded;

      case 'reminder':
        return Icons.notifications_active_rounded;

      case 'appointment':
        return Icons.calendar_month_rounded;

      default:
        return Icons.notifications_active_outlined;
    }
  }
  void addNotification({
    required String title,
    required String body,
    required String createdAt,
    required String type,
  }) {
    notifications.insert(0, {
      "title": title,
      "body": body,
      "created_at": createdAt,
      "type": type,
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