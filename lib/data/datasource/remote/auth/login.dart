import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class LoginData{

  Crud crud;

  LoginData(this.crud);

  postData(String email,String password ,String? fcmToken) async{
    var response =await crud.PostData(AppLink.login, {
      "email" :email ,
      "password" : password,
       "fcm_token":fcmToken,

    });

    return response.fold((l) => l, (r) => r);
  }

}