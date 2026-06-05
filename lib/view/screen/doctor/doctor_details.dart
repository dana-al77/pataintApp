import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/screen/doctor/reviews/reviews_tab.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            clipBehavior: Clip.none,
            children: [
              DoctorHeader(doctor: widget.doctor),

              Positioned(
                top: 270, // عدل حسب ارتفاع الهيدر
                left: 0,
                right: 0,
                child: DoctorStats(
                  doctor: widget.doctor,
                  reviewController: reviewController,
                ),
              ),
            ],
          ),
        //  DoctorStats(doctor: widget.doctor),

          const SizedBox(height: 50),

          /// 🔥 TAB BAR
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(4),
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                return TabBar(
                  controller: tabController,
                  // 👇 هدول السطرين هما السر لمنع الرجة وتغيير الحجم الافتراضي
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColor.secondyColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.secondyColor.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  dividerColor: Colors.transparent,
                  tabs: [

                    _buildCustomTab(text: "المواعيد", index: 0),
                    _buildCustomTab(text: "التقييمات", index: 1),
                    _buildCustomTab(text: "معلومات", index: 2),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                /// 📅 SCHEDULE
                _scheduleTab(),
                /// ⭐ REVIEWS
                ReviewsTab(
                  doctorId: widget.doctor.doctorId!.toString(),
                ),
                /// 🩺 INFO
                _infoTab(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

  /// =========================
  /// ⭐ REVIEW DIALOG
  /// =========================
  Widget _buildCustomTab({required String text, required int index}) {
    final bool isUnselected = tabController.index != index;

    return Tab(
      // 👇 قفلنا الارتفاع بـ 45 بكسل ثابتين للكل لمنع أي تغيير بالحجم
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        // 👇 مسافة جانبية ثابتة وموحدة بين الأزرار لتبتعد عن بعضها بشكل منظم
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // البوردر ثابت الحجم (1.2) دائماً، التغير فقط باللون لمنع أي اهتزاز بكسل واحد
          border: Border.all(
            color: isUnselected
                ? Colors.grey.withOpacity(0.35)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
