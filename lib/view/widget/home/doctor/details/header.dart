import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/widget/home/doctor/details/wave.dart';
import '../../../../../data/model/doctor.dart';
import '../../../../../core/constant/imageasset.dart';

class DoctorHeader extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// 🔵 الخلفية مع الموجة
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
          //   color: AppColor.secondyColor.withOpacity(0.7),
                gradient: LinearGradient(
                  colors: [
                    AppColor.inactiveDotColor.withOpacity(0.1),
                    AppColor.secondyColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),


        /// 📦 المحتوى
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              /// 🧑‍⚕️ صورة الدكتور
              Container(
                height: 300,
                alignment: Alignment.topRight,
                child: Transform.translate(
                  offset: const Offset(0, 30),
                  child: Container(
                    child: Image.network(
                      doctor.image ?? "",
                      height: 250,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            AppImageAsset.doctors,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                ),
              ),

              /// 🔙 زر الرجوع
              Positioned(
                top: 50,
                left: 0,
                child: _buildCircleIcon(
                  Icons.arrow_forward_ios,
                      () => Get.back(),
                ),
              ),

              /*   /// 💬 زر الرسائل
              Positioned(
                top: 50,
                right: 0,
                child: _buildCircleIcon(
                  Icons.chat_bubble_outline,
                      () {},
                ),
              ),
*/
              Positioned(
                top: 120,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🩺 التخصص
                    Text(
                      doctor.specialization ?? "Cardiologyist",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                   // const SizedBox(height: 6),

                    /// 👨‍⚕️ اسم الدكتور
              Text(
                      " د.${doctor.name}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2, // 👈 spacing بين السطر
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 💲 السعر
                    Text(
                      "hr / \$20.0",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ⭐ التقييم (محسن)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, size: 16, color: Colors.orange),
                          SizedBox(width: 6),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔘 زر دائري
  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppColor.black),
      ),
    );
  }
}

