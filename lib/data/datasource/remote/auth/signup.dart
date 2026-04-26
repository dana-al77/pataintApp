
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class SignupData{

  Crud crud;

  SignupData(this.crud);

  postData(String name,
      String email,
      String password,
      String password_confirmation,
      String role,
      String? fcmToken, // 👈 جديد
      ) async{
    var response =await crud.PostData(AppLink.signup, {
      "name" :name ,
      "email" : email,
      "password" : password,
      "password_confirmation":password_confirmation,
      "role":role,
      "fcm_token":fcmToken



    });

    return response.fold((l) => l, (r) => r);
  }

}