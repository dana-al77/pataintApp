
import 'package:flutter/material.dart';

import '../../../controller/profile/profile_controller.dart';
import '../../../core/constant/color.dart';
import 'edit_button.dart';
class ProfileInfo extends StatelessWidget {
  final ProfileController controller;

  const ProfileInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.profileModel?.name ?? "Unknown",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
         // const Text("مريض",style: TextStyle(color: AppColor.grey),),
          const SizedBox(height: 6),


                          Row(
                            children: [
                              const Icon(Icons.email,
                                  size: 16,
                                  color: AppColor.secondyColor),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  controller
                                      .profileModel
                                      ?.email ??
                                      "-",
                                  style: const TextStyle(
                                      color:
                                      Colors.black87),
                                  overflow: TextOverflow
                                      .ellipsis,
                                ),
                              ),
                            ],
                          ),
          const SizedBox(height: 10),

          const EditProfileButton(),
        ],
      ),
    );
  }
}