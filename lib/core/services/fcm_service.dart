import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/routes.dart';

import '../../controller/notification_controller.dart';
class FCMService {

  // 🔔 Plugin لعرض الإشعار
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // 🔥 تهيئة الإشعارات
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 🔥 جلب التوكن
  static Future<String?> getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    String? token = await messaging.getToken();

    print("🔥====== FCM TOKEN ==========: $token");

    return token;
  }

  // 🔔 استقبال الإشعارات
  static void setupListeners() {

    // ✅ لما الإشعار يوصل والتطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔥 وصل إشعار");
      print("🔔 إشعار وصل والتطبيق مفتوح");
      print("==================Title: ${message.notification?.title}");
      print("Body====================: ${message.notification?.body}");

      String title = message.notification?.title ?? "";
      String body = message.notification?.body ?? "";

      final controller = Get.find<NotificationController>();

      controller.addNotification(title, body);

      if (message.notification != null &&
          !controller.isNotificationScreenOpen) {
        showNotification(
          message.notification!.title ?? "",
          message.notification!.body ?? "",
        );
      }

      if (message.data.isNotEmpty) {
        print("DATA: ${message.data}");
      }
    });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("🔥 وصل إشعار");
    //   print("🔔 إشعار وصل والتطبيق مفتوح");
    //   print("==================Title: ${message.notification?.title}");
    //   print("Body====================: ${message.notification?.body}");
    //   String title = message.notification?.title ?? "";
    //   String body = message.notification?.body ?? "";
    //   Get.find<NotificationController>().addNotification(title, body);
    //   if (message.notification != null) {
    //     showNotification(
    //       message.notification!.title ?? "",
    //       message.notification!.body ?? "",
    //     );
    //   }
    //
    //   // 👇 أضيفي هذا
    //   if (message.data.isNotEmpty) {
    //     print("DATA: ${message.data}");
    //   }
    // });
    // ✅ لما المستخدم يضغط على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📲 المستخدم ضغط على الإشعار");
      print("📲 المستخدم ضغط على الإشعار");

      String? type = message.data['type'];
      String title = message.notification?.title ?? "";
      String body = message.notification?.body ?? "";

      Get.find<NotificationController>().addNotification(title, body);

      // 👇 لاحقًا تفتح صفحة
      Get.toNamed(
          AppRoute.notification ,
        arguments: {
          "title": message.notification?.title,
          "body": message.notification?.body,
        },
      );
    });

  }

  // 🔔 دالة عرض الإشعار
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }
}