import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrView extends StatefulWidget {
  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {

  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("مسح QR"),
      ),

      body: MobileScanner(

        onDetect: (capture) {

          if (isScanCompleted) return;

          final List<Barcode> barcodes = capture.barcodes;

          for (final barcode in barcodes) {

            final String code = barcode.rawValue ?? "";

            if (code.isNotEmpty) {

              isScanCompleted = true;

              print("QR RESULT = $code");

              /// هون الرابط الموجود داخل QR

              Get.snackbar(
                "تم المسح",
                code,
              );

              /// ابعتيه للباك اند
              /// أو افتحي صفحة السجل الطبي

              Future.delayed(
                const Duration(seconds: 2),
                    () {
                  closeScreen();
                },
              );
            }
          }
        },
      ),
    );
  }
}