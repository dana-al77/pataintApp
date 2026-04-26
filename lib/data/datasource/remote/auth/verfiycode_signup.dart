
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class VerifyCodeSignUpData{

  Crud crud;

  VerifyCodeSignUpData(this.crud);

  postData(String email,String verifycode,String? fcmToken) async{
    var response =await crud.PostData(AppLink.verifyCode, {

      "email" : email,
      "code" : verifycode,
      "fcm_token":fcmToken


    });

    return response.fold((l) => l, (r) => r);
  }

}