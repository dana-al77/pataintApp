import 'package:flutter/material.dart';

import '../../../../data/model/center_info.dart';

class CenterInfoCard extends StatelessWidget {
  final CenterInfo model;

  const CenterInfoCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          icon: Icons.location_on,
          title: "الموقع",
          subtitle: model.location ?? "",
        ),
        _buildCard(
          icon: Icons.access_time,
          title: "ساعات العمل",
          subtitle: model.openingHours ?? "",
        ),
        _buildCard(
          icon: Icons.map,
          title: "العنوان على الخريطة",
          subtitle: model.addressOnMap ?? "",
          hasImage: true,
        ),
        _buildCard(
          icon: Icons.account_tree,
          title: "الفروع",
          subtitle: model.branches ?? "",
        ),
        _buildServicesCard(),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    bool hasImage = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.teal),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/clinic.jpg", // حطي صورة خريطة
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),

          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildServicesCard() {
    List<String> services =
    (model.services ?? "").split(" - "); // تقسيم الخدمات

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.favorite, color: Colors.teal),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("الخدمات المتوفرة",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: services.map((e) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle,
                            size: 16, color: Colors.teal),
                        const SizedBox(width: 4),
                        Text(e),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}