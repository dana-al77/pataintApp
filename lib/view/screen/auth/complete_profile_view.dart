import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/complete_profile_controller.dart';
import '../../../core/class/handling_data_view.dart';
import '../../../core/constant/color.dart';
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
              children:[
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/background.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                  ),
                ),

                Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Form(
                  key: controller.formstate,
                  child: ListView(
                    children: [
                      SizedBox(height: 100),
                      CustomTextTitleAuth(text: "أكمل بياناتك الشخصية"),
                      SizedBox(height: 10),
                      CustomTextBodyAuth(
                          text: "هذه البيانات تساعدنا على تقديم خدمة أفضل"),
                      SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue.shade100.withOpacity(0.5),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03), // ظل خفيف جداً
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [

                            CustomDateField(
                              hintText: "yyyy-mm-dd",
                              labelText: "تاريخ الميلاد",
                              iconData: Icons.calendar_today,
                              controller: controller.dateOfBirth,
                              valid: (val){
                                return validInput(val!, 10, 10, "date");                              },
                            ),

                            Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: CustomDropdownFormAuth<String>(
                                    hindtext: "اختر المحافظة",
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
                                    valid: (val){
                                      return validInput(val!, 3, 100, "name");
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: CustomDropdownFormAuth<String>(
                                    hindtext: "اختر المدينة",
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
                                    valid: (val){
                                      return validInput(val!, 3, 100, "name");
                                    },                                  ),
                                ),
                              ],
                            ),
                            CustomTextFormAuth(
                              hindtext: "رقم الطوارئ",
                              labeltext: "رقم الاتصال في الطوارئ",
                              iconData: Icons.phone,
                              mycontroller: controller.emergencyContact,
                              valid: phoneValidator,
                              isNumber: true,
                              prefixText:  "+963 9 ",

                            ),

                            CustomDropdownFormAuth<String>(
                              hindtext: "اختر الجنس",
                              labeltext: "الجنس",
                              iconData: Icons.male,
                              value: controller.selectedGender, // متغير جديد في Controller
                              items: ["ذكر", "أنثى"].map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              )).toList(),
                              onChanged: (val) {
                                controller.selectedGender = val;
                                controller.update(); // لتحديث الـ GetBuilder
                              },
                              valid: (val){
                                return validInput(val!, 3, 100, "name");
                              },                            ),

                            CustomTextFormAuth(
                              hindtext: "رقم الهاتف",
                              labeltext: "رقم الهاتف",
                              iconData: Icons.phone_android,
                              mycontroller: controller.phone,
                              valid:phoneValidator,
                              isNumber: true,
                              prefixText:  "+963 9 ",
                            ),
                            SizedBox(height: 20),
                            CustomButtonAuth(
                              text: "أكمل",
                              onPressed: () => controller.completeProfile(),
                            ),
                            SizedBox(height: 15),

                            GestureDetector(
                              onTap: () {
                                showCustomDialog(
                                  title: "إكمال لاحقاً؟",
                                  message: "إكمال بياناتك يساعدنا على تقديم تجربة أفضل، هل تريد المتابعة بدون إكمال؟",
                                  icon: Icons.info_outline,

                                  confirmText: "متابعة",
                                  cancelText: "إلغاء",

                                  onConfirm: () {
                                    controller.skip();
                                  },
                                );
                              },
                              child: Center(
                                child: Text(
                                  "إكمال لاحقاً",
                                  style: TextStyle(
                                    color: AppColor.thirdColor ,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

         ]   ),
          ),
        ),
      ),
    );
  }
}