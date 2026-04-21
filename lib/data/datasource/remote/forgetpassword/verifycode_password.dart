// import '../../../../core/class/crud.dart';
// import '../../../../link_api.dart';
//
// class VerifyCodeForgetPassword{
//
//   Crud crud;
//
//   VerifyCodeForgetPassword(this.crud);
//
//   postData(String email,String verifycode) async{
//     var response =await crud.PostData(AppLink.resetpassword, {
//       "email" :email ,
//       "code" : verifycode,
//
//
//     });
//
//     return response.fold((l) => l, (r) => r);
//   }
//
// }