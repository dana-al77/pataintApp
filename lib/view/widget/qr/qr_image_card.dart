// ===============================
// qr_image_card.dart
// ===============================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QrImageCard extends StatelessWidget {

  final String qrUrl;
  final GlobalKey qrKey;
  const QrImageCard({
    super.key,
    required this.qrUrl,
    required this.qrKey,
  });

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
        key: qrKey,
        child:
      Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        child: SvgPicture.network(
          qrUrl,

          height: 220,
          width: 220,

          placeholderBuilder: (context) =>
          const SizedBox(
            height: 220,
            width: 220,

            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    ));
  }
}