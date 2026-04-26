import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/routes.dart';
import 'binding/init_binding.dart';
import 'core/constant/app_theme.dart';
import 'core/localization/changedlocal.dart';
import 'core/localization/translation.dart';
import 'core/services/fcm_service.dart';
import 'core/services/services.dart';
import 'root.dart';
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("📩 إشعار بالخلفية وصل");
// }
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // تهيئة Firebase
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   await FCMService.init(); // 👈 مهم جدًا
//   FCMService.setupListeners();
//   //// اول ما شغل بيكون هاد السيرفيسيس جاهز
//   await initialServices();
//   runApp(
//     ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return const MyApp();
//       },
//     ),
//   );
//
// }
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("📩 إشعار بالخلفية وصل");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FCMService.init();
  FCMService.setupListeners();

  await initialServices();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );

  // 👇 👇 👇 هذا الجزء ضيفيه هون بالضبط
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    print("🚀 فتح التطبيق من إشعار");

    String? type = initialMessage.data['type'];

    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(
        AppRoute.notification,
        arguments: {
          "title": initialMessage.notification?.title,
          "body": initialMessage.notification?.body,
        },
      );
      // if (type == "support") {
      //   Get.toNamed(AppRoute.notification);
      // } else if (type == "appointment") {
      //   Get.toNamed("/appointments");
      // } else {
      //   Get.toNamed("/notifications");
      // }
    });
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller=Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
     // theme: controller.appTheme,

        theme:  themeArabic,
      initialBinding: InitialBindings(),
      //routes: routes,
      getPages:routes,
      // builder: (context, child) {
      //   return Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: child!,
      //   );
      // },

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
    );
  }
}

