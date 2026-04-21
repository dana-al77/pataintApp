
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class VerifyCodeSignUpData{

  Crud crud;

  VerifyCodeSignUpData(this.crud);

  postData(String email,String verifycode) async{
    var response =await crud.PostData(AppLink.verifyCode, {

      "email" : email,
      "code" : verifycode,


    });

    return response.fold((l) => l, (r) => r);
  }

}