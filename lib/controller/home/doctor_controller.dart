import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../data/datasource/remote/doctor_data.dart';
import '../../data/datasource/remote/search_data.dart';
import '../../data/model/doctor.dart';

abstract class DoctorController extends GetxController {
  getDoctors();
}

class DoctorControllerImp extends DoctorController {
  StatusRequest statusRequest = StatusRequest.none;

  DoctorData doctorData = DoctorData(Get.find());

  List<DoctorModel> data = [];

  TextEditingController searchController = TextEditingController();
  SearchDoctorsData searchDoctorsData = SearchDoctorsData(Get.find());

  bool isSearch = false;
 // List doctorsSearchList = [];
  List<DoctorModel> doctorsSearchList = [];
  Timer? debounce;

  checkSearch(String val) {
    if (val.isEmpty) {
      isSearch = false;
      doctorsSearchList.clear();
    } else {
      isSearch = true;
    }
    update();
  }

  clearSearch() {
    searchController.clear();
    isSearch = false;
    doctorsSearchList.clear();
    update();
  }

  onSearchChanged(String val) {
    checkSearch(val);

    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      searchData();
    });
  }

  searchData() async {
    if (searchController.text.isEmpty) return;

    statusRequest = StatusRequest.loading;
    update();

    var response =
    await searchDoctorsData.getData(searchController.text);

    print("==============================response $response");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {

        doctorsSearchList.clear();

        List list = response['data'];

        doctorsSearchList.addAll(
          list.map((e) => DoctorModel.fromJson(e)),
        );

      } else {
        doctorsSearchList.clear();
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
  @override
  getDoctors() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await doctorData.get();

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        List list = response['data'];
        data.addAll(list.map((e) => DoctorModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    getDoctors();
    super.onInit();
  }
}