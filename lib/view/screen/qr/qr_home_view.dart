import 'package:flutter/material.dart';

import 'medical_record_page.dart';
import 'scan_qr_view.dart';

class QrHomeView extends StatelessWidget {
  const QrHomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,

      child: Scaffold(

        appBar: AppBar(

          title: const Text("QR"),

          bottom: const TabBar(

            tabs: [

              Tab(
                text: "QR الخاص بي",
              ),

              Tab(
                text: "مسح الرمز",
              ),
            ],
          ),
        ),

        body: const TabBarView(

          children: [

            MedicalQrView(),

            ScanQrView(),
          ],
        ),
      ),
    );
  }
}