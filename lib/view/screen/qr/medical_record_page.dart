import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/medical_record_qr_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/color.dart';
import '../../widget/qr/qr_action_button.dart';
import '../../widget/qr/qr_action_row.dart';
import '../../widget/qr/qr_header.dart';
import '../../widget/qr/qr_image_card.dart';
import '../../widget/qr/qr_text.dart';
import 'FullMedicalRecordView.dart';


// ===============================
// medical_qr_view.dart
// ===============================


class MedicalQrView extends StatelessWidget {
  const MedicalQrView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicalQrController());

    return Scaffold(
      backgroundColor: AppColor.white,

      body: SafeArea(
        child: GetBuilder<MedicalQrController>(
          builder: (controller) {
            return handlingDataView(
              statusRequest: controller.statusRequest,

              widget: Builder(
                builder: (context) {

                  final record =
                  controller.medicalQrModel!.data!.medicalRecord!;

                  final qrUrl =
                  controller.medicalQrModel!.data!.qrCodeUrl!;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: AppColor.backgroundColor,
                      ),

                      child: Column(
                        children: [

                          /// HEADER
                          QrHeader(record: record),

                          const SizedBox(height: 40),

                          /// QR SECTION
                          Column(
                            children: [

                              /// QR IMAGE
                              QrImageCard(qrUrl: qrUrl,qrKey: controller.qrKey),

                              const SizedBox(height: 22),

                              /// DESCRIPTION
                              const InfoText(
                                text:
                                "امسح الرمز للوصول الآمن إلى السجل الطبي",
                              ),

                              const SizedBox(height: 30),

                              /// FIRST BUTTON ROW
                              ActionButtonsRow(
                                firstIcon: Icons.share,
                                firstTitle: "مشاركة QR",
                                firstTap: () {
                                  controller.shareQrImage();
                                },

                                secondIcon: Icons.download,
                                secondTitle: "حفظ QR",
                                secondTap: () {
                                  controller.saveQrAsImage();
                                },
                              ),

                              const SizedBox(height: 12),

                              /// SECOND BUTTON ROW
                              ActionButtonsRow(
                                firstIcon: Icons.copy,
                                firstTitle: "نسخ الرابط",
                                firstTap: () async {
                                  final link = controller.medicalQrModel!.data!.qrCodeUrl!;

                                  await Clipboard.setData(
                                    ClipboardData(text: link),
                                  );

                                  Get.snackbar(
                                    "Copied",
                                    "QR link copied to clipboard",
                                  );
                                },

                                secondIcon: Icons.file_download,
                                secondTitle: "تنزيل",
                                secondTap: () {
                                  controller.downloadQrImage();
                                },
                              ),

                              const SizedBox(height: 25),

                              /// SECURITY TEXT
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey.shade600,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12), // مسافة بسيطة بين الأيقونة والنص
                                  Flexible(
                                    child: Text(
                                      "رمز QR الطبي الخاص بك مشفر وآمن تماماً.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              IconButton(onPressed: (){
Get.to(() => FullMedicalRecordView());
}, icon: Icon(Icons.add)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


// class MedicalQrView extends StatelessWidget {
//   const MedicalQrView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(MedicalQrController());
//
//     return Scaffold(
//       backgroundColor: AppColor.white,
//
//       body: SafeArea(
//         child: GetBuilder<MedicalQrController>(
//           builder: (controller) {
//             return handlingDataView(
//               statusRequest: controller.statusRequest,
//
//               widget: Builder(
//                 builder: (context) {
//
//                   final record =
//                   controller.medicalQrModel!.data!.medicalRecord!;
//
//                   return SingleChildScrollView(
//                     padding: const EdgeInsets.all(16),
//
//                     child:Container(
//
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(35),
//                         color: AppColor.backgroundColor,
//                       ),
//                       child: Column(
//                           children: [
//
//                             /// TOP BLUE HEADER
//                             Container(
//                               //height: 150,
//                               width: double.infinity,
//
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(35),
//                                   topRight: Radius.circular(35),
//                                 ),
//                                 // gradient: LinearGradient(
//                                 //   colors: [
//                                 //     Color(0xff53B2FF),
//                                 //     Color(0xff007BFF),
//                                 //   ],
//                                 //   begin: Alignment.topLeft,
//                                 //   end: Alignment.bottomRight,
//                                 // ),
//                                 color: AppColor.secondyColor
//                               ),
//
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 18,
//                                   vertical: 18,
//                                 ),
//
//                                 child: Column(
//                                   children: [
//
//                                     /// TOP BAR
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//
//                                       children: [
//
//                                         _circleIcon(Icons.arrow_back_ios_new),
//
//                                         const Text(
//                                           "My Medical QR",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//
//                                         _circleIcon(Icons.add),
//                                       ],
//                                     ),
//
//                                     const SizedBox(height: 20),
//
//                                     /// USER CARD
//                                     Container(
//                                       padding: const EdgeInsets.all(14),
//
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                         BorderRadius.circular(22),
//
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black
//                                                 .withOpacity(0.05),
//                                             blurRadius: 10,
//                                             offset: const Offset(0, 5),
//                                           ),
//                                         ],
//                                       ),
//
//                                       child: Row(
//                                         children: [
//
//                                           /// IMAGE
//                                           CircleAvatar(
//                                             radius: 30,
//                                             backgroundColor:
//                                             Colors.blue.shade50,
//
//                                             backgroundImage:
//                                             record.profileImage != null
//                                                 ? NetworkImage(
//                                               record.profileImage!,
//                                             )
//                                                 : null,
//
//                                             child: record.profileImage == null
//                                                 ? const Icon(
//                                               Icons.person,
//                                               size: 35,
//                                             )
//                                                 : null,
//                                           ),
//
//                                           const SizedBox(width: 14),
//
//                                           /// NAME + EMAIL
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//
//                                               children: [
//
//                                                 Text(
//                                                   record.patientName ?? "",
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                     FontWeight.bold,
//                                                   ),
//                                                 ),
//
//                                                 const SizedBox(height: 4),
//
//                                                 Text(
//                                                   record.email ?? "",
//                                                   style: TextStyle(
//                                                     color: Colors.grey.shade600,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//
//                                           /// VERIFIED
//                                           Container(
//                                             padding:
//                                             const EdgeInsets.symmetric(
//                                               horizontal: 10,
//                                               vertical: 6,
//                                             ),
//
//                                             decoration: BoxDecoration(
//                                               color: Colors.blue.shade50,
//                                               borderRadius:
//                                               BorderRadius.circular(30),
//                                             ),
//
//                                             child: Row(
//                                               children: const [
//
//                                                 Icon(
//                                                   Icons.verified,
//                                                   color: AppColor.secondyColor,
//                                                   size: 18,
//                                                 ),
//
//                                                 SizedBox(width: 4),
//
//                                                 Text(
//                                                   "verified",
//                                                   style: TextStyle(
//                                                     color: AppColor.secondyColor,
//                                                     fontWeight:
//                                                     FontWeight.w600,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             const SizedBox(height: 40),
//
//                             /// QR CARD
//                             Column(
//                               children: [
//
//                                 /// QR CONTAINER
//                                 Container(
//                                   padding: const EdgeInsets.all(20),
//
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(25),
//
//                                   ),
//
//                                   child: ClipRRect(
//                                     borderRadius:
//                                     BorderRadius.circular(20),
//
//                                     child: SvgPicture.network(
//                                       controller
//                                           .medicalQrModel!
//                                           .data!
//                                           .qrCodeUrl!,
//
//                                       height: 220,
//                                       width: 220,
//
//                                       placeholderBuilder: (context) =>
//                                       const SizedBox(
//                                         height: 220,
//                                         width: 220,
//                                         child: Center(
//                                           child:
//                                           CircularProgressIndicator(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 22),
//
//                                 Text(
//                                   "Scan to securely access medical record",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade700,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 30),
//
//                                 /// BUTTONS
//                                  Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                                child:  Row(
//                                   children: [
//
//                                     Expanded(
//                                       child: _actionButton(
//                                         icon: Icons.share,
//                                         title: "Share QR",
//                                         onTap: () {},
//                                       ),
//                                     ),
//
//                                     const SizedBox(width: 12),
//
//                                     Expanded(
//                                       child: _actionButton(
//                                         icon: Icons.download,
//                                         title: "Save QR",
//                                         onTap: () {},
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                  ),
//                                 const SizedBox(height: 12),
//
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                                   child: Row(
//                                   children: [
//
//                                     Expanded(
//                                       child: _actionButton(
//                                         icon: Icons.copy,
//                                         title: "Copy Link",
//                                         onTap: () {},
//                                       ),
//                                     ),
//
//                                     const SizedBox(width: 12),
//
//                                     Expanded(
//                                       child: _actionButton(
//                                         icon: Icons.file_download,
//                                         title: "Download",
//                                         onTap: () {},
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ),
//                                 const SizedBox(height: 25),
//
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//
//                                   children: [
//
//                                     Icon(
//                                       Icons.lock_outline,
//                                       color: Colors.grey.shade600,
//                                       size: 18,
//                                     ),
//
//                                     const SizedBox(width: 6),
//
//                                     Text(
//                                       "Your medical QR is encrypted and secure",
//                                       style: TextStyle(
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 30),
//                           ],
//                         ),
//                     ),
//
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   static Widget _circleIcon(IconData icon) {
//     return Container(
//       height: 42,
//       width: 42,
//
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         shape: BoxShape.circle,
//       ),
//
//       child: Icon(
//         icon,
//         color: Colors.white,
//       ),
//     );
//   }
//
//   static Widget _actionButton({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(18),
//       onTap: onTap,
//
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: 14,
//         ),
//
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: Colors.blue,
//
//               child: Icon(
//                 icon,
//                 color: Colors.white,
//                 size: 18,
//               ),
//             ),
//
//             const SizedBox(width: 8),
//
//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// IconButton(onPressed: (){
// Get.to(() => FullMedicalRecordView());
// }, icon: Icon(Icons.add)),