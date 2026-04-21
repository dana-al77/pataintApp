// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/homescreen_controller.dart';
// import '../../core/constant/color.dart';
// import 'custombottomappbar.dart';
//
//
// class CustomBottomAppBarHome extends StatelessWidget {
//   const CustomBottomAppBarHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeScreenControllerImp>(
//       builder: (controller) => BottomAppBar(
//         color: AppColor.white,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly, // توزيع متساوي
//
//           children: [
//             ...List.generate(
//               controller.listPage.length + 1,
//                   (index) {
//                 int i = index > 2 ? index - 1 : index;
//                 if (index == 2) return const Center();
//                 return Expanded(
//                   child: CustomButtonAppBar(
//
//                     textbutton: controller.titlebottomappbar[i]["title"].toString(),
//                     icondata: controller.titlebottomappbar[i]["icon"] as IconData,
//                     onPressed: () {
//                       controller.changePage(i);
//                     },
//                     active: controller.currentpage == i,
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/homescreen_controller.dart';
import '../../core/constant/color.dart';
import 'buttom_clipper.dart';
import 'custombottomappbar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Stack(
          clipBehavior: Clip.none,
          children: [

            // 🔵 البار مع الفراغ
            ClipPath(
              clipper: BottomBarClipper(controller.currentpage),
              child: Container(

                height: 80,
                color: AppColor.white,
                child: Row(
                  children: List.generate(
                    controller.listPage.length,
                        (i) => CustomButtonAppBar(
                      textbutton: controller.titlebottomappbar[i]["title"],
                      icondata: controller.titlebottomappbar[i]["icon"],
                      onPressed: () => controller.changePage(i),
                      active: controller.currentpage == i,
                    ),
                  ),
                ),
              ),
            ),

            // 🔥 الأيقونة النشطة (المهم)
            Positioned(
              top: -25,
              left: _calculatePosition(context, controller.currentpage),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  controller.titlebottomappbar[controller.currentpage]["icon"],
                  color: AppColor.secondyColor,
                  size: 26,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
double _calculatePosition(BuildContext context, int index) {
  int itemCount = 4;

  int fixedIndex = itemCount - 1 - index;

  double width = MediaQuery.of(context).size.width;
  double itemWidth = width / itemCount;

  double centerX = (fixedIndex * itemWidth) + itemWidth / 2;

  return centerX - 22;
}