
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ResetPasswordData{

  Crud crud;

  ResetPasswordData(this.crud);

  postData(String email, String code, String password, String password_confirmation) async {
    var response = await crud.PostData(
      AppLink.resetpassword,
      {
        "email": email,
        "code": code,
        "password": password,
        "password_confirmation": password_confirmation,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}