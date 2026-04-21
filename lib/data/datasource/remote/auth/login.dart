import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class LoginData{

  Crud crud;

  LoginData(this.crud);

  postData(String email,String password) async{
    var response =await crud.PostData(AppLink.login, {
      "email" :email ,
      "password" : password,


    });

    return response.fold((l) => l, (r) => r);
  }

}