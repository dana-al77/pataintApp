import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/complete_profile_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageasset.dart';
import '../../../core/functions/show_skip_dialog.dart';
import '../../../core/functions/valid_input.dart';

import '../../widget/auth/CustomDropdownFormAuth.dart';
import '../../widget/auth/custom_date_field.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitlleauth.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CompleteProfileControllerImp());

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GetBuilder<CompleteProfileControllerImp>(
          builder: (controller) => handlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Stack(
              children: [

                /// 🌌 الخلفية
                Positioned.fill(
                  child: Image.asset(
                    AppImageAsset.DNABackGround2,
                    fit: BoxFit.cover,
                  ),
                ),

                /// 📦 المحتوى
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          /// 🧬 لوجو + صورة المستخدم (Glass Circle)
                          GestureDetector(
                            onTap: () {
                              controller.chooseImage();
                            },
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [

                                  /// الزجاج الخلفي
                                  ClipOval(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.15),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// الصورة
                                  controller.imageFile != null
                                      ? ClipOval(
                                    child: Image.file(
                                      controller.imageFile!,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  ),

                                  /// أيقونة الكاميرا
                                  Positioned(
                                    bottom: 22,
                                    right: 22,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColor.secondyColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// 🧊 Glass Container
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25),
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),

                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.25),
                                      Colors.white.withOpacity(0.3),
                                    ],
                                  ),

                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                  ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 25,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),

                                child: Form(
                                  key: controller.formstate,
                                  child: Column(
                                    children: [

                                      // /// 📝 عناوين
                                      // CustomTextTitleAuth(text: "أكمل بياناتك"),
                                      // CustomTextBodyAuth(
                                      //     text: "هذه المعلومات تساعدنا بخدمتك بشكل أفضل"),
                                      //
                                      // const SizedBox(height: 25),

                                      /// 📅 تاريخ الميلاد
                                      CustomDateField(
                                        hintText: "yyyy-mm-dd",
                                        labelText: "تاريخ الميلاد",
                                        iconData: Icons.calendar_today,
                                        controller: controller.dateOfBirth,
                                        valid: (val) {
                                          return validInput(val!, 10, 10, "date");
                                        },
                                      ),

                                      /// 📍 المحافظة + المدينة
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomDropdownFormAuth<String>(
                                              hindtext: "المحافظة",
                                              labeltext: "المحافظة",
                                              iconData: Icons.location_city,
                                              value: controller.selectedGovernorate,
                                              items: controller.governoratesAndCities.keys
                                                  .map((gov) => DropdownMenuItem(
                                                value: gov,
                                                child: Text(gov),
                                              ))
                                                  .toList(),
                                              onChanged: controller.changeGovernorate,
                                              valid: (val) {
                                                return validInput(val!, 3, 100, "name");
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: CustomDropdownFormAuth<String>(
                                              hindtext: "المدينة",
                                              labeltext: "المدينة",
                                              iconData: Icons.location_on,
                                              value: controller.selectedCity,
                                              items: controller.cities
                                                  .map((city) => DropdownMenuItem(
                                                value: city,
                                                child: Text(city),
                                              ))
                                                  .toList(),
                                              onChanged: controller.changeCity,
                                              valid: (val) {
                                                return validInput(val!, 3, 100, "name");
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// ☎️ طوارئ
                                      CustomTextFormAuth(
                                        hindtext: "رقم الطوارئ",
                                        labeltext: "رقم الطوارئ",
                                        iconData: Icons.phone,
                                        mycontroller: controller.emergencyContact,
                                        valid: phoneValidator,
                                        isNumber: true,
                                        prefixText: "+963 9 ",
                                      ),

                                      /// 👤 الجنس
                                      CustomDropdownFormAuth<String>(
                                        hindtext: "الجنس",
                                        labeltext: "الجنس",
                                        iconData: Icons.male,
                                        value: controller.selectedGender,
                                        items: ["ذكر", "أنثى"]
                                            .map((g) => DropdownMenuItem(
                                          value: g,
                                          child: Text(g),
                                        ))
                                            .toList(),
                                        onChanged: (val) {
                                          controller.selectedGender = val;
                                          controller.update();
                                        },
                                        valid: (val) {
                                          return validInput(val!, 3, 100, "name");
                                        },
                                      ),

                                      /// 📱 الهاتف
                                      CustomTextFormAuth(
                                        hindtext: "رقم الهاتف",
                                        labeltext: "رقم الهاتف",
                                        iconData: Icons.phone_android,
                                        mycontroller: controller.phone,
                                        valid: phoneValidator,
                                        isNumber: true,
                                        prefixText: "+963 9 ",
                                      ),

                                      const SizedBox(height: 20),

                                      /// 🔘 زر
                                      CustomButtonAuth(
                                        text: "أكمل",
                                        onPressed: () =>
                                            controller.completeProfile(),
                                      ),

                                      const SizedBox(height: 15),

                                      /// ⏭️ تخطي
                                      GestureDetector(
                                        onTap: () {
                                          showCustomDialog(
                                            title: "إكمال لاحقاً؟",
                                            message:
                                            "هل تريد المتابعة بدون إكمال البيانات؟",
                                            icon: Icons.info_outline,
                                            confirmText: "متابعة",
                                            cancelText: "إلغاء",
                                            onConfirm: () {
                                              controller.skip();
                                            },
                                          );
                                        },
                                        child: Text(
                                          "إكمال لاحقاً",
                                          style: TextStyle(
                                            color: AppColor.black,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/auth/complete_profile_controller.dart';
// import '../../../core/class/handling_data_view.dart';
// import '../../../core/constant/color.dart';
// import '../../../core/functions/show_skip_dialog.dart';
// import '../../../core/functions/valid_input.dart';
// import '../../widget/auth/CustomDropdownFormAuth.dart';
// import '../../widget/auth/custom_date_field.dart';
// import '../../widget/auth/custombuttonauth.dart';
// import '../../widget/auth/customtextbodyauth.dart';
// import '../../widget/auth/customtextformauth.dart';
// import '../../widget/auth/customtexttitlleauth.dart';
//
// class CompleteProfile extends StatelessWidget {
//   const CompleteProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(CompleteProfileControllerImp());
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () async => false,
//         child: GetBuilder<CompleteProfileControllerImp>(
//           builder: (controller) => handlingDataRequest(
//             statusRequest: controller.statusRequest,
//             widget: Stack(
//               children:[
//                 Positioned.fill(
//                   child: Image.asset(
//                     "assets/images/background.jpg",
//                     fit: BoxFit.cover,
//                     alignment: Alignment.center,
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Container(
//                   ),
//                 ),
//
//                 Container(
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 child: Form(
//                   key: controller.formstate,
//                   child: ListView(
//                     children: [
//
//                       SizedBox(height: 100),
//                       GestureDetector(
//                         onTap: () {
//                           controller.chooseImage();
//                         },
//                         child: Center(
//                           child: Stack(
//                             children: [
//                               Container(
//                                 width: 110,
//                                 height: 110,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.blue, width: 2),
//                                 ),
//                                 child: controller.imageFile != null
//                                     ? ClipOval(
//                                   child: Image.file(
//                                     controller.imageFile!,
//                                     fit: BoxFit.cover,
//                                     width: 110,
//                                     height: 110,
//                                   ),
//                                 )
//                                     : const Center(
//                                   child: Icon(
//                                     Icons.person,
//                                     size: 50,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//
//                               // ✨ أيقونة الكاميرا الصغيرة
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: const BoxDecoration(
//                                     color: Colors.blue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // CustomTextTitleAuth(text: "أكمل بياناتك الشخصية"),
//                       // SizedBox(height: 10),
//                       // CustomTextBodyAuth(
//                       //     text: "هذه البيانات تساعدنا على تقديم خدمة أفضل"),
//                        SizedBox(height: 20),
//
//                       Container(
//                         padding: const EdgeInsets.all(25),
//                         decoration: BoxDecoration(
//                           color: AppColor.backgroundColor,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.blue.shade100.withOpacity(0.5),
//                             width: 1.2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
//                               blurRadius: 15,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//
//                             CustomDateField(
//                               hintText: "yyyy-mm-dd",
//                               labelText: "تاريخ الميلاد",
//                               iconData: Icons.calendar_today,
//                               controller: controller.dateOfBirth,
//                               valid: (val){
//                                 return validInput(val!, 10, 10, "date");                              },
//                             ),
//
//                             Row(
//                               children: [
//                                 Flexible(
//                                   fit: FlexFit.tight,
//                                   child: CustomDropdownFormAuth<String>(
//                                     hindtext: "اختر المحافظة",
//                                     labeltext: "المحافظة",
//                                     iconData: Icons.location_city,
//                                     value: controller.selectedGovernorate,
//                                     items: controller.governoratesAndCities.keys
//                                         .map((gov) => DropdownMenuItem(
//                                       value: gov,
//                                       child: Text(gov),
//                                     ))
//                                         .toList(),
//                                     onChanged: controller.changeGovernorate,
//                                     valid: (val){
//                                       return validInput(val!, 3, 100, "name");
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Flexible(
//                                   fit: FlexFit.tight,
//                                   child: CustomDropdownFormAuth<String>(
//                                     hindtext: "اختر المدينة",
//                                     labeltext: "المدينة",
//                                     iconData: Icons.location_on,
//                                     value: controller.selectedCity,
//                                     items: controller.cities
//                                         .map((city) => DropdownMenuItem(
//                                       value: city,
//                                       child: Text(city),
//                                     ))
//                                         .toList(),
//                                     onChanged: controller.changeCity,
//                                     valid: (val){
//                                       return validInput(val!, 3, 100, "name");
//                                     },                                  ),
//                                 ),
//                               ],
//                             ),
//                             CustomTextFormAuth(
//                               hindtext: "رقم الطوارئ",
//                               labeltext: "رقم الاتصال في الطوارئ",
//                               iconData: Icons.phone,
//                               mycontroller: controller.emergencyContact,
//                               valid: phoneValidator,
//                               isNumber: true,
//                               prefixText:  "+963 9 ",
//
//                             ),
//
//                             CustomDropdownFormAuth<String>(
//                               hindtext: "اختر الجنس",
//                               labeltext: "الجنس",
//                               iconData: Icons.male,
//                               value: controller.selectedGender, // متغير جديد في Controller
//                               items: ["ذكر", "أنثى"].map((gender) => DropdownMenuItem(
//                                 value: gender,
//                                 child: Text(gender),
//                               )).toList(),
//                               onChanged: (val) {
//                                 controller.selectedGender = val;
//                                 controller.update(); // لتحديث الـ GetBuilder
//                               },
//                               valid: (val){
//                                 return validInput(val!, 3, 100, "name");
//                               },                            ),
//
//                             CustomTextFormAuth(
//                               hindtext: "رقم الهاتف",
//                               labeltext: "رقم الهاتف",
//                               iconData: Icons.phone_android,
//                               mycontroller: controller.phone,
//                               valid:phoneValidator,
//                               isNumber: true,
//                               prefixText:  "+963 9 ",
//                             ),
//                             SizedBox(height: 20),
//                             CustomButtonAuth(
//                               text: "أكمل",
//                               onPressed: () => controller.completeProfile(),
//                             ),
//                             SizedBox(height: 15),
//
//                             GestureDetector(
//                               onTap: () {
//                                 showCustomDialog(
//                                   title: "إكمال لاحقاً؟",
//                                   message: "إكمال بياناتك يساعدنا على تقديم تجربة أفضل، هل تريد المتابعة بدون إكمال؟",
//                                   icon: Icons.info_outline,
//
//                                   confirmText: "متابعة",
//                                   cancelText: "إلغاء",
//
//                                   onConfirm: () {
//                                     controller.skip();
//                                   },
//                                 );
//                               },
//                               child: Center(
//                                 child: Text(
//                                   "إكمال لاحقاً",
//                                   style: TextStyle(
//                                     color: AppColor.thirdColor ,
//                                     fontSize: 15,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//
//          ]   ),
//           ),
//         ),
//       ),
//     );
//   }
// }