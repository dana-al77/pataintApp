// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/notification_controller.dart';
//
// class Notificationview extends StatelessWidget {
//   const Notificationview({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("الإشعارات"),
//         centerTitle: true,
//       ),
//       body: GetBuilder<NotificationController>(
//         builder: (controller) {
//           if (controller.notifications.isEmpty) {
//             return const Center(
//               child: Text("لا يوجد إشعارات"),
//             );
//           }
//
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: controller.notifications.length,
//             itemBuilder: (context, index) {
//               final notif = controller.notifications[index];
//
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       notif['title'] ?? "",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       notif['body'] ?? "",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


///////////////////////  قبل تعديل المنظر
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/notification_controller.dart';

class Notificationview extends StatefulWidget {
  const Notificationview({super.key});

  @override
  State<Notificationview> createState() => _NotificationviewState();
}

class _NotificationviewState extends State<Notificationview> {
  final NotificationController controller =
  Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();

    controller.isNotificationScreenOpen = true;
  }

  @override
  void dispose() {
    controller.isNotificationScreenOpen = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        centerTitle: true,
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.notifications.isEmpty) {
            return const Center(
              child: Text("لا يوجد إشعارات"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notif = controller.notifications[index];
               return Container(
                 margin: const EdgeInsets.only(bottom: 16),
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(24),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.05),
                       blurRadius: 20,
                       offset: const Offset(0, 8),
                     ),
                   ],
                 ),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     /// Notification Icon
                     Container(
                       width: 55,
                       height: 55,
                       decoration: BoxDecoration(
                         color: controller.getNotificationBackgroundColor(
                           notif['type'],
                         ),
                         borderRadius: BorderRadius.circular(18),
                       ),
                       child: Icon(
                         controller.getNotificationIcon(
                           notif['type'],
                         ),
                         color: controller.getNotificationColor(
                           notif['type'],
                         ),
                         size: 28,
                       ),
                     ),
                     const SizedBox(width: 14),

                     /// Content
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           Row(
                             children: [
                               Expanded(
                                 child: Text(
                                   notif['title'] ?? '',
                                   style: const TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ),

                               /// Unread Badge
                               Container(
                                 width: 10,
                                 height: 10,
                                 decoration: const BoxDecoration(
                                   color: Colors.red,
                                   shape: BoxShape.circle,
                                 ),
                               ),
                             ],
                           ),

                           const SizedBox(height: 8),

                           Text(
                             notif['body'] ?? '',
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                               fontSize: 13,
                               color: Colors.grey.shade600,
                               height: 1.5,
                             ),
                           ),

                           const SizedBox(height: 12),

                           Row(
                             children: [
                               Icon(
                                 Icons.access_time_rounded,
                                 size: 15,
                                 color: Colors.grey.shade500,
                               ),
                               const SizedBox(width: 5),
                               Text(
                                 controller.getTimeAgo(
                                   notif['created_at'] ?? '',
                                 ),
                                 style: TextStyle(
                                   fontSize: 12,
                                   color: Colors.grey.shade500,
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               );
              // return Container(
              //   margin: const EdgeInsets.only(bottom: 10),
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.05),
              //         blurRadius: 10,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         notif['title'] ?? "",
              //         style: const TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(height: 6),
              //       Text(
              //         notif['body'] ?? "",
              //         style: const TextStyle(
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}