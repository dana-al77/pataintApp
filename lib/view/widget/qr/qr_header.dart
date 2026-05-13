// ===============================
// qr_header.dart
// ===============================

import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../data/model/medical_record_model.dart';
import 'qr_user_card.dart';

class QrHeader extends StatelessWidget {

  final MedicalRecord record;

  const QrHeader({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColor.secondyColor,
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        child: Column(
          children: [

            /// TOP BAR
            Row(
              children: [
                // 1. فراغ في جهة اليسار موازي لحجم الأيقونة (لضمان التوسط)
                const SizedBox(width: 42),

                // 2. النص في المنتصف تماماً
                const Expanded(
                  child: Center(
                    child: Text(
                      "QR السجل الطبي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 3. سهم العودة على اليمين
                _circleIcon(Icons.arrow_forward_ios),
              ],
            ),

            const SizedBox(height: 20),

            /// USER CARD
            QrUserCard(record: record),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {

    return Container(
      height: 42,
      width: 42,

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),

      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}