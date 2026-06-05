import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/widget/home/doctor/details/wave.dart';
import '../../../../../controller/review_controller.dart';
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
                   AppColor.secondyColor.withOpacity(0.5),
                    AppColor.blueColor.withOpacity(0.2),

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),


        /// 📦 المحتوى
        Container(
          padding: const EdgeInsets.only(left: 1,right: 10),
          child: Stack(
            children: [
              /// 🧑‍⚕️ صورة الدكتور
              Container(
                height: 300,
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(0, 45),
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
                right: 10,
                child: _buildCircleIcon(
                  Icons.arrow_back_ios_new_rounded,
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
                top: 180,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                   // const SizedBox(height: 6),

                    /// 👨‍⚕️ اسم الدكتور
              Text(
                      " د.${doctor.name}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                       // height: 1.2, // 👈 spacing بين السطر
                      ),
                    ),
                    /// 🩺 التخصص
                    Text(
                      doctor.specialization ?? "Cardiologyist",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // /// 💲 السعر
                    // Text(
                    //   "hr / \$20.0",
                    //   style: TextStyle(
                    //     color: Colors.blue.shade700,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),

                    GetBuilder<ReviewController>(
                      builder: (controller) {
                        double rating = controller.averageRating;

                        int fullStars = rating.floor(); // النجوم الكاملة
                        bool hasHalfStar = (rating - fullStars) >= 0.5;

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                        //    color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// ⭐ النجوم
                              Row(
                                children: List.generate(5, (index) {
                                  if (index < fullStars) {
                                    return const Icon(Icons.star,
                                        size: 16, color: Colors.orange);
                                  } else if (index == fullStars && hasHalfStar) {
                                    return const Icon(Icons.star_half,
                                        size: 16, color: Colors.orange);
                                  } else {
                                    return const Icon(Icons.star_border,
                                        size: 16, color: Colors.orange);
                                  }
                                }),
                              ),

                              const SizedBox(width: 6),

                              /// ⭐ الرقم
                              Text(
                                rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(width: 4),

                              // /// ⭐ عدد التقييمات
                              // Text(
                              //   "(${controller.totalReviews})",
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.grey.shade600,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                    /// ⭐ التقييم (محسن)
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.85),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.star, size: 16, color: Colors.orange),
                    //       SizedBox(width: 6),
                    //       Text(
                    //         "4.8",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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

