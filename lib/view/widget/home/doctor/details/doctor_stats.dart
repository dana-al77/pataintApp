
import 'package:flutter/material.dart';
import 'package:patientapp/view/widget/home/doctor/details/stat_item.dart';

import '../../../../../data/model/doctor.dart';
// class DoctorStats extends StatelessWidget {
//   final DoctorModel doctor;
//
//   const DoctorStats({super.key, required this.doctor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       child:Container(
//
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: _buildStatCard(
//                 child: StatItem(
//                   value: "${doctor.experienceYears ?? 0} years",
//                   title: "الخبرة",
//                   icon: Icons.work_outline,
//                   iconColor: Colors.blue,
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 10),
//
//             Expanded(
//               child: _buildStatCard(
//                 child: const StatItem(
//                   value: "2456",
//                   title: "عدد المرضى",
//                   icon: Icons.people_outline,
//                   iconColor: Colors.green,
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 10),
//
//             Expanded(
//               child: _buildStatCard(
//                 child: const StatItem(
//                   value: "2.4k",
//                   title: "التقييمات",
//                   icon: Icons.star_border,
//                   iconColor: Colors.orange,
//                 ),
//               ),
//             ),
//           ],
//         )
//       )
//     );
//   }
// }
// Widget _buildStatCard({required Widget child}) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 12),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(14),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.04),
//           blurRadius: 8,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Center(child: child),
//   );
// }

class DoctorStats extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorStats({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stat(Icons.people, "2456", "مريض", Colors.green),

          _divider(),

          _stat(Icons.star, "2.4k", "تقييم", Colors.orange),

          _divider(),

          _stat(Icons.work, "${doctor.experienceYears ?? 0}", "سنوات", Colors.blue),
        ],
      ),
    );
  }
}
Widget _stat(IconData icon, String value, String label, Color color) {
  return Column(
    children: [
      Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      const SizedBox(height: 4),

      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
    ],
  );
}

Widget _divider() {
  return Container(
    height: 40,
    width: 1,
    color: Colors.grey.withOpacity(0.4),
  );
}