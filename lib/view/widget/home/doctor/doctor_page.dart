import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/home/doctor_controller.dart';
import '../../../../core/constant/color.dart';
import '../customsearchfield.dart';
import 'list_doctors_home.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: const Text("جميع الأطباء" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body: Column(children: [
        GetBuilder<DoctorControllerImp>(
          builder:(controller) {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomSearchField(
                controller: controller.searchController,
                hintText: "ابحث عن طبيب...",
                isSearching: controller.isSearch,
                onClear: controller.clearSearch,
                onChanged: (val) {

                    controller.onSearchChanged(val);

                },
              ),
            );
          },
        ),
        Expanded(child: const ListDoctorsHome())]),
    );
  }
}