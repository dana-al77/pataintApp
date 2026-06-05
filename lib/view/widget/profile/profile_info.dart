
import 'package:flutter/material.dart';

import '../../../controller/profile/profile_controller.dart';
import '../../../core/constant/color.dart';
import 'edit_button.dart';
class ProfileInfo extends StatelessWidget {
  final ProfileController controller;

  const ProfileInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          controller.profileModel?.name ?? "Unknown",
          style: const TextStyle(
            fontSize: 18,
           // fontWeight: FontWeight.bold,
            color: AppColor.white

          ),
        ),
       // const Text("مريض",style: TextStyle(color: AppColor.grey),),


        Row(
          children:[
            Icon(Icons.email,color: Colors.black54,size: 15,),
            SizedBox(width: 4,),
            Text(
            controller.profileModel?.email ?? "-",
            style: const TextStyle(color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
       ] ),
//        const SizedBox(height: 10),

       // const EditProfileButton(),
      ],
    );
  }
}