import 'package:patientapp/link_api.dart';

import '../../../../core/class/crud.dart';

class ResendOtpData {
  Crud crud;
  ResendOtpData(this.crud);

  postData(String email) async {
    var response = await crud.PostData(AppLink.resendOtp,
      {
        "email": email,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}