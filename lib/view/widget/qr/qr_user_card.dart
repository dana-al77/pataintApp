// ===============================
// qr_user_card.dart
// ===============================

import 'package:flutter/material.dart';

import '../../../data/model/medical_record_model.dart';
import '../../../../core/constant/color.dart';

class QrUserCard extends StatelessWidget {

  final MedicalRecord record;

  const QrUserCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          /// IMAGE
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade50,

            backgroundImage:
            record.profileImage != null
                ? NetworkImage(record.profileImage!)
                : null,

            child: record.profileImage == null
                ? const Icon(
              Icons.person,
              size: 35,
            )
                : null,
          ),

          const SizedBox(width: 14),

          /// NAME + EMAIL
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  record.patientName ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  record.email ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          /// VERIFIED
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(30),
            ),

            child: const Row(
              children: [

                Icon(
                  Icons.verified,
                  color: AppColor.secondyColor,
                  size: 18,
                ),

                SizedBox(width: 4),

                Text(
                  "موثق",
                  style: TextStyle(
                    color: AppColor.secondyColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}