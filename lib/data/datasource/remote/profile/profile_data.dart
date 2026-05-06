import 'dart:io';

import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ProfileData {
  Crud crud;

  ProfileData(this.crud);

  getData() async {
    var response = await crud.PostDataWithToken(
      AppLink.showprofile,
      {},
    );

    return response.fold((l) => l, (r) => r);
  }

  updateData(
      Map<String, dynamic> data, {
        File? imageFile,
      }) async {

    if (imageFile != null) {
      var response = await crud.postDataWithFileAndToken(
        AppLink.profile,
        data,
        imageFile,
        "profile_image",
      );

      return response.fold((l) => l, (r) => r);

    } else {
      var response = await crud.PostDataWithToken(
        AppLink.profile,
        data,
      );

      return response.fold((l) => l, (r) => r);
    }
  }
}