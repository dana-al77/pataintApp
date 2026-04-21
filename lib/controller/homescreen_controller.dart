import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/NotificationView.dart';
import '../view/screen/appiontement/first_appiontement_view.dart';
import '../view/screen/home.dart';
import '../view/screen/profile.dart';
import '../view/widget/home/centerInfo/list_center_info.dart';


abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
     const Home(),
    ListCenterInfo(),
    FirstAppiontementView(),
    Profile(),

  ];

  List titlebottomappbar = [
    {"title": "الرئيسية", "icon": Icons.home},
    {"title": "المركز", "icon": Icons.medical_information},
   {"title": "الحجوزات", "icon": Icons.calendar_month},
    {"title": "الحساب", "icon": Icons.person},
  ];
  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
