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
  String? errorMessage;
  getMedicalQr() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await medicalQrData.getMedicalQr();


    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        medicalQrModel = MedicalQrModel.fromJson(response);
      }
      else if (response['status'] == 404) {
        statusRequest = StatusRequest.noData;
      }
      else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
  // getMedicalQr() async {
  //
  //   statusRequest = StatusRequest.loading;
  //   update();
  //
  //   var response = await medicalQrData.getMedicalQr();
  //
  //   statusRequest = handlingData(response);
  //
  //   if (statusRequest == StatusRequest.success) {
  //
  //     if (response['success'] == true) {
  //
  //       medicalQrModel = MedicalQrModel.fromJson(response);
  //
  //     } else if (response['status'] == 404) {
  //
  //       errorMessage = response['error'];
  //
  //       Get.defaultDialog(
  //         title: "تنبيه",
  //         middleText: response['error'] ?? "لا يوجد سجل طبي لهذا المريض",
  //         textConfirm: "حسناً",
  //         onConfirm: () {
  //           Get.back();
  //           Get.back(); // إذا بدك ترجع للصفحة السابقة
  //         },
  //       );
  //
  //       statusRequest = StatusRequest.none;
  //
  //     } else {
  //
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //
  //   update();
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