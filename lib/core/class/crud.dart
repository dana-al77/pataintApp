import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:patientapp/core/class/statusrequest.dart';
import '../services/services.dart';

MyServices myServices = Get.find();
String? token = myServices.sharedPreferences.getString("token");

// String _basicAuth =
//     'Basic ${base64Encode(utf8.encode('dddd:sdfsdfsdfsdfdsf'))}';
Map<String,String> _myheaders={    //authorization':_basicAuth,
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};

class Crud{


  Future<Either<StatusRequest,Map>> PostData( String linkurl, Map data) async{
try{

    print("🚀 Sending data: $data"); // اطبع البيانات قبل الإرسال

    var response = await http.post(Uri.parse(
        linkurl),
        headers: {

          'Accept': 'application/json',

        },
        body:data
    );
    // if(response.statusCode == 200 ||response.statusCode == 201 ){
    //
    //   Map responsebody = jsonDecode(response.body);
    //   return Right(responsebody);
    // }else{
    //   print("❌ Server returned error:");
    //   print("🔢 Status code: ${response.statusCode}");
    //   print("📦 Response body: ${response.body}");
    //   return Left(StatusRequest.serverfailure);
    //
    // }
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);

    } else if (response.statusCode == 400 || response.statusCode == 422) {
      // 👈 Validation error (مثل الإيميل غلط)
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);

    } else if (response.statusCode == 401) {
      return Left(StatusRequest.failure);

    } else if (response.statusCode >= 500) {
      return Left(StatusRequest.serverfailure);

    } else {
      return Left(StatusRequest.serverExption);
    }
  }


catch(e){
  print("❗ Exception occurred: $e");  // هذا مهم جداً

  return Left(StatusRequest.serverExption);
}
}

  Future<Either<StatusRequest, Map>> PostDataWithToken(String linkurl,Map data) async {
    try {

      var response = await http.post(Uri.parse(linkurl),
          headers: {

            'Accept': 'application/json',
            'Authorization': 'Bearer $token',

          },
          body:data);
      if (response.statusCode == 200) {
        Map responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        print("❌ Server returned error:");
        print("🔢 Status code: ${response.statusCode}");
        print("📦 Response body: ${response.body}");
        return Left(StatusRequest.serverfailure);
      }

    } catch (e) {
      print("❗ Exception occurred: $e");
      return Left(StatusRequest.serverExption);
    }
  }



  Future<Either<StatusRequest, Map>> DeleteData(String linkurl) async {
    try {
      var response = await http.delete(
        Uri.parse(linkurl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right({"status": "success"});
      } else {
        print("❌ Error: ${response.statusCode}");
        print("📦 Body: ${response.body}");
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print("❗ Exception: $e");
      return Left(StatusRequest.serverExption);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl) async {
    try {
      final url = Uri.parse(linkurl);
      print("🟢 TOKEN USED: $token");
       final response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    //  print("📥 Raw response body:\n${response.body}");
      if (response.statusCode == 200) {
        print(url);
        try {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);
          // print("✅ Decoded JSON: $responsebody");
          return Right(responsebody);
        } catch (e) {
          print("❗ Error decoding JSON: $e");
          return Left(StatusRequest.serverExption);
        }
      } else {
        print("❌ Server returned error:");
        print("🔢 Status code: ${response.statusCode}");
        print("📦 Response body:\n${response.body}");
        return Left(StatusRequest.serverfailure);
      }

    } catch (e) {
      print("❗ Unexpected exception occurred: $e");
      return Left(StatusRequest.serverExption);
    }
  }



}