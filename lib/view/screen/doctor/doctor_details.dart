import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';
import 'package:patientapp/view/screen/doctor/select_date.dart';
import 'package:patientapp/view/screen/doctor/time_slote.dart';

import '../../../controller/appiontement/appiontement_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imageasset.dart';
import '../../../data/model/doctor.dart';
import '../../widget/home/doctor/details/doctor_stats.dart';
import '../../widget/home/doctor/details/header.dart';
import 'bio.dart';
import 'booking_button.dart';
class DoctorDetailsPage extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  late AppointmentController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(AppointmentController());

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: SafeArea(
        child: BookingButton(
          doctorId: widget.doctor.doctorId!,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Column(
              children: [

                DoctorHeader(doctor: widget.doctor),

               const SizedBox(height: 5),

                DoctorStats(doctor: widget.doctor),
                const SizedBox(height: 5),
                DoctorBio(bio: widget.doctor.bio),
                const SizedBox(height: 5),

                ScheduleDateWidget(doctor: widget.doctor),
                const SizedBox(height: 5),

                ScheduleTimeWidget(),

              ],
            )

          ],
        ),
      ),
    );
  }
}