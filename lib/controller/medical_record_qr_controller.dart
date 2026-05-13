import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vision_gallery_saver/vision_gallery_saver.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../data/datasource/remote/medical_record_qr_data.dart';
import '../data/model/medical_record_model.dart';

class MedicalQrController extends GetxController {

  StatusRequest statusRequest = StatusRequest.none;

  MedicalQrData medicalQrData = MedicalQrData(Get.find());

  MedicalQrModel? medicalQrModel;

  final GlobalKey qrKey = GlobalKey();

  getMedicalQr() async {

    statusRequest = StatusRequest.loading;
    update();

    var response = await medicalQrData.getMedicalQr();

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {

      if (response['success'] == true) {

        medicalQrModel =
            MedicalQrModel.fromJson(response);

      } else {

        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
  // saveQrToGallery(String imageUrl) async {
  //
  //   /// REQUEST PERMISSION
  //   var permission = await Permission.storage.request();
  //
  //   if (!permission.isGranted) {
  //
  //     Get.snackbar(
  //       "Permission Denied",
  //       "Storage permission is required",
  //     );
  //
  //     return;
  //   }
  //
  //   try {
  //
  //     /// DOWNLOAD IMAGE
  //     final response = await http.get(Uri.parse(imageUrl));
  //
  //     Uint8List bytes = response.bodyBytes;
  //
  //     /// SAVE TO GALLERY
  //     final result = await ImageGallerySaver.saveImage(
  //       bytes,
  //       quality: 100,
  //       name: "medical_qr",
  //     );
  //
  //     if (result['isSuccess'] == true) {
  //
  //       Get.snackbar(
  //         "Success",
  //         "QR saved to gallery",
  //       );
  //
  //     } else {
  //
  //       Get.snackbar(
  //         "Error",
  //         "Failed to save QR",
  //       );
  //     }
  //
  //   } catch (e) {
  //
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //     );
  //   }
  // }
  // saveQrToGallery(String imageUrl) async {
  //   print("QR URL: $imageUrl"); // 👈 هون
  //   try {
  //
  //     /// DOWNLOAD IMAGE
  //     final response = await http.get(
  //       Uri.parse(imageUrl),
  //     );
  //
  //
  //
  //     /// SAVE TO GALLERY
  //     await VisionGallerySaver.saveImage(
  //       response.bodyBytes,
  //       name: "medical_qr",
  //     );
  //
  //     Get.snackbar(
  //       "Success",
  //       "QR saved to gallery",
  //     );
  //
  //   } catch (e) {
  //
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //     );
  //   }
  // }
  Future<void> saveQrAsImage() async {
    try {
      RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final success = await VisionGallerySaver.saveImage(
        pngBytes,
        name: "medical_qr",
      );
      print("SAVE RESULT: $success");
      if (success['isSuccess'] == true) {
        Get.snackbar("Success", "Saved to Gallery ✔");
      } else {
        Get.snackbar("Error", "Failed to save image");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> shareQrImage() async {
    try {
      RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();

      final file = File('${dir.path}/qr_share.png');

      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "My Medical QR Code",
      );

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  Future<void> downloadQrImage() async {
    try {
      RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      /// 📁 Get Downloads directory
      final dir = await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/medical_qr.png');

      await file.writeAsBytes(pngBytes);

      Get.snackbar(
        "Downloaded ✔",
        "Saved in app storage folder",
      );

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    getMedicalQr();
    super.onInit();
  }
}