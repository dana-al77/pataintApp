import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/profile/edit_profile_controller.dart';
import '../divider.dart';
import '../info_tilte.dart';



class EditProfileSection extends StatelessWidget {
  const EditProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: GetBuilder<EditProfileController>(
          builder: (controller) {
            return Column(
              children: [

                /// ================= DOB =================
                InfoRowTile(
                  icon: Icons.calendar_today,
                  iconColor: Colors.blue,
                  iconBackground: Colors.blue.withOpacity(0.1),
                  title: "تاريخ الميلاد",
                  value: controller.dateOfBirth.text,

                  isEditing: false,

                  trailingIcon: Icons.edit,
                  onTrailingTap: () {
                    controller.pickDate();
                  },
                ),

                const divider(),

                /// ================= GOVERNORATE =================
                // InfoRowTile(
                //   icon: Icons.location_city,
                //   iconColor: Colors.orange,
                //   iconBackground: Colors.orange.withOpacity(0.1),
                //   title: "المحافظة",
                //   value: "",
                //
                //   isEditing: true,
                //
                //   editableChild: DropdownButtonFormField<String>(
                //     value: controller.selectedGovernorate,
                //     items: controller.governoratesAndCities.keys
                //         .map((e) => DropdownMenuItem(
                //       value: e,
                //       child: Text(e),
                //     ))
                //         .toList(),
                //     onChanged: controller.changeGovernorate,
                //     decoration: const InputDecoration(border: InputBorder.none),
                //   ),
                // ),
                InfoRowTile(
                  icon: Icons.location_city,
                  iconColor: Colors.orange,
                  iconBackground: Colors.orange.withOpacity(0.1),
                  title: "المحافظة",

                  value: "",

                  isEditing: true,

                  editableChild: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedGovernorate,
                      isDense: true, // 🔥 يقلل الارتفاع
                      isExpanded: true,

                      iconSize: 18,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),

                      items: controller.governoratesAndCities.keys
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),

                      onChanged: (value) {
                        controller.changeGovernorate(value);
                      },
                    ),
                  ),
                ),
                const divider(),

                /// ================= CITY =================
                ///
                // InfoRowTile(
                //   icon: Icons.public,
                //   iconColor: Colors.green,
                //   iconBackground: Colors.green.withOpacity(0.1),
                //   title: "البلدة",
                //   value: "",
                //
                //   isEditing: true,
                //
                //   editableChild: DropdownButtonFormField<String>(
                //     value: controller.selectedCity,
                //     items: controller.cities
                //         .map((e) => DropdownMenuItem(
                //       value: e,
                //       child: Text(e),
                //     ))
                //         .toList(),
                //     onChanged: controller.changeCity,
                //     decoration: const InputDecoration(border: InputBorder.none),
                //   ),
                // ),
                InfoRowTile(
                  icon: Icons.public,
                  iconColor: Colors.green,
                  iconBackground: Colors.green.withOpacity(0.1),
                  title: "البلدة",

                  value: "",

                  isEditing: true,

                  editableChild: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedCity,
                      isDense: true, // 🔥 يقلل الارتفاع
                      isExpanded: true,

                      iconSize: 18,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),

                      items: controller.cities
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),

                      onChanged: (value) {
                        controller.changeCity(value);
                      },
                    ),
                  ),
                ),
                const divider(),

                /// ================= PHONE =================
                InfoRowTile(
                  icon: Icons.phone,
                  iconColor: Colors.red,
                  iconBackground: const Color(0x1AFF0000),
                  title: "رقم الطوارئ",
                  value: controller.emergencyContact.text,

                  isEditing: controller.editingField == "phone",

                  editableChild: TextField(
                    controller: controller.emergencyContact,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onSubmitted: (_) => controller.stopEditing(),
                  ),

                  trailingIcon: Icons.edit,
                  onTrailingTap: () {
                    controller.startEditing("phone");
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}