import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/screen/doctor/select_date.dart';
import 'package:patientapp/view/screen/doctor/time_slote.dart';

import '../../../controller/appiontement/appiontement_controller.dart';
import '../../../controller/review_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imageasset.dart';
import '../../../core/functions/format.dart';
import '../../../data/model/doctor.dart';
import '../../widget/home/doctor/details/doctor_stats.dart';
import '../../widget/home/doctor/details/header.dart';
import '../review_view.dart';
import 'bio.dart';
import 'booking_button.dart';
class DoctorDetailsPage extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage>
    with SingleTickerProviderStateMixin {

  late AppointmentController controller;
  late ReviewController reviewController;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    controller = Get.put(AppointmentController());

    reviewController = Get.put(ReviewController());
    reviewController.getReviews(widget.doctor.doctorId!.toString());
    /// 🔥 TAB CONTROLLER
    tabController = TabController(length: 3, vsync: this);

    if (widget.doctor.schedules != null &&
        widget.doctor.schedules!.isNotEmpty) {

      final first = widget.doctor.schedules!.first;

      controller.selectDate(
        widget.doctor.doctorId!,
        first.date!,
      );
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      bottomNavigationBar: SafeArea(
        child: BookingButton(
          doctorId: widget.doctor.doctorId!,
        ),
      ),

      body: Column(
        children: [

          /// 🔥 HEADER
          DoctorHeader(doctor: widget.doctor),

          const SizedBox(height: 5),

          /// 🔥 STATS
          DoctorStats(doctor: widget.doctor),

          const SizedBox(height: 10),

          /// 🔥 TAB BAR
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                color: AppColor.secondyColor,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "معلومات"),
                Tab(text: "المواعيد"),
                Tab(text: "التقييمات"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [

                /// 🩺 INFO
                _infoTab(),

                /// 📅 SCHEDULE
                _scheduleTab(),

                /// ⭐ REVIEWS
                _reviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// 🩺 INFO TAB
  /// =========================
  Widget _infoTab() {
    return SingleChildScrollView(
      child: Column(
        children: [

          DoctorBio(
            bio: widget.doctor.bio,
          ),

        ],
      ),
    );
  }

  /// =========================
  /// 📅 SCHEDULE TAB
  /// =========================
  Widget _scheduleTab() {
    return SingleChildScrollView(
      child: Column(
        children: [

          ScheduleDateWidget(
            doctor: widget.doctor,
          ),

          const SizedBox(height: 10),

          const ScheduleTimeWidget(),

        ],
      ),
    );
  }

  /// =========================
  /// ⭐ REVIEWS TAB
  /// =========================
  Widget _reviewsTab() {
    return Column(
      children: [

        const SizedBox(height: 10),

        /// ➕ زر إضافة تقييم
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.secondyColor,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: _showReviewDialog,
            icon: const Icon(Icons.star, color: Colors.white),
            label: const Text("إضافة تقييم"),
          ),
        ),

        const SizedBox(height: 10),

        /// 📦 LIST
        Expanded(
          child: GetBuilder<ReviewController>(
            builder: (ctrl) {

              if (ctrl.reviews.isEmpty) {
                return const Center(child: Text("لا يوجد تقييمات"));
              }

              return ListView.builder(
                itemCount: ctrl.reviews.length,
                itemBuilder: (context, index) {

                  final review = ctrl.reviews[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 👤 Avatar
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: review.patient?.profileImage != null
                              ? NetworkImage(review.patient!.profileImage!)
                              : null,
                          child: review.patient?.profileImage == null
                              ? Text(review.patient?.name[0] ?? "")
                              : null,
                        ),

                        const SizedBox(width: 12),

                        /// 📦 CONTENT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// 👤 NAME + DATE
                              Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      review.patient?.name ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    formatDate(review.createAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              /// ⭐ STARS
                              Row(
                                children: List.generate(
                                  review.rating,
                                      (i) => const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              /// 💬 COMMENT
                              Text(
                                review.comment ?? "لا يوجد تعليق",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
  /// =========================
  /// ⭐ REVIEW DIALOG
  /// =========================
  void _showReviewDialog() {

    Get.dialog(

      GetBuilder<ReviewController>(

        init: reviewController,

        builder: (ctrl) {

          return AlertDialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            title: const Text("أضف تقييم"),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ⭐ STARS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: List.generate(5, (index) {

                    return IconButton(

                      onPressed: () {
                        ctrl.setRating(index + 1);
                      },

                      icon: Icon(
                        Icons.star,

                        color: index < ctrl.rating
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 10),

                /// 💬 COMMENT
                TextField(
                  controller: ctrl.comment,

                  maxLines: 3,

                  decoration: InputDecoration(
                    hintText: "اكتب تعليقك...",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            actions: [

              TextButton(
                onPressed: () {
                  Get.back();
                },

                child: const Text("إلغاء"),
              ),

              ElevatedButton(
                onPressed: () {

                  ctrl.addReview(
                    widget.doctor.doctorId!.toString(),
                  );

                  Get.back();
                },

                child: const Text("إرسال"),
              ),
            ],
          );
        },
      ),
    );
  }
}//       SingleChildScrollView(
//         child: Column(
//           children: [
//
//             Column(
//               children: [
//
//                 DoctorHeader(doctor: widget.doctor),
//
//                const SizedBox(height: 5),
//
//                 DoctorStats(doctor: widget.doctor),
//                 const SizedBox(height: 5),
//
//                 DoctorBio(bio: widget.doctor.bio),
//                 const SizedBox(height: 5),
//
//                 ScheduleDateWidget(doctor: widget.doctor),
//                 const SizedBox(height: 5),
//
//                 ScheduleTimeWidget(),
//
//               ],
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
