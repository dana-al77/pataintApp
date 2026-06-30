import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:patientapp/core/class/statusrequest.dart';
import '../services/services.dart';

MyServices myServices = Get.find();
//String? token = myServices.sharedPreferences.getString("token");



class Crud{


  Future<Either<StatusRequest,Map>> PostData( String linkurl, Map data) async{
try{

    print("🚀 Sending data: $data"); // اطبع البيانات قبل الإرسال
    print("🌐 URL: $linkurl");

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
      print("🔢 STATUS CODE: ${response.statusCode}");
      print("📦 RESPONSE BODY: ${response.body}");
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
  Future<Either<StatusRequest, Map>> postDataWithFileAndToken(
      String linkUrl,
      Map data,
      File imageFile,
      String imageKey, // 👈 اسم الحقل مثل profile_image
      ) async {
    try {
      String? token = myServices.sharedPreferences.getString("token"); // ✅ هون الصح

      print("🔐 TOKEN: $token");

      var request = http.MultipartRequest("POST", Uri.parse(linkUrl));

      // 📦 إضافة البيانات
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // 📷 إضافة الصورة
      request.files.add(
        await http.MultipartFile.fromPath(imageKey, imageFile.path),
      );

      // 🔐 الهيدر
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      var streamed = await request.send();
      var response = await http.Response.fromStream(streamed);

      print("📩 Status: ${streamed.statusCode}");
      print("📩 Body: ${response.body}");

      if (streamed.statusCode >= 200 && streamed.statusCode < 300) {
        return Right(jsonDecode(response.body));
      } else {
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print("❗ ERROR: $e");
      return Left(StatusRequest.serverExption);
    }
  }
  Future<Either<StatusRequest, Map>> PostDataWithToken(String linkurl,Map data) async {
    try {
      String? token = myServices.sharedPreferences.getString("token"); // ✅ هون الصح


      print("🌐 URL: $linkurl");
      print("📤 DATA: $data");
      print("🔐 TOKEN: $token");
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


  // Future<Either<StatusRequest, Map>> postDataUpLoad(
  //     String linkUrl,
  //     Map data,
  //     List<File> imageFiles,
  //     String imageKey,
  //     ) async {
  //   try {
  //
  //     String? token =
  //     myServices.sharedPreferences.getString("token");
  //
  //     var request =
  //     http.MultipartRequest("POST", Uri.parse(linkUrl));
  //
  //     // fields
  //     data.forEach((key, value) {
  //       request.fields[key] = value.toString();
  //     });
  //
  //     // files
  //     for (var file in imageFiles) {
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           imageKey,
  //           file.path,
  //         ),
  //       );
  //     }
  //
  //     request.headers.addAll({
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $token",
  //     });
  //
  //     var streamed = await request.send();
  //
  //     var response =
  //     await http.Response.fromStream(streamed);
  //
  //     print(response.body);
  //
  //     if (streamed.statusCode >= 200 &&
  //         streamed.statusCode < 300) {
  //
  //       return Right(jsonDecode(response.body));
  //
  //     } else {
  //
  //       return Left(StatusRequest.serverfailure);
  //     }
  //
  //   } catch (e) {
  //
  //     print(e);
  //
  //     return Left(StatusRequest.serverExption);
  //   }
  // }
  Future<Either<StatusRequest, Map>> postDataUpLoad(
      String linkUrl,
      Map data,
      List<File> imageFiles,
      String imageKey,
      ) async {
    try {
      String? token = myServices.sharedPreferences.getString("token");

      var request = http.MultipartRequest("POST", Uri.parse(linkUrl));

      // إضافة البيانات (Fields)
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // إضافة الملفات
      for (var file in imageFiles) {
        request.files.add(
          await http.MultipartFile.fromPath(
            imageKey,
            file.path,
          ),
        );
      }

      // إضافة الهيدرز
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      // إرسال الطلب
      var streamed = await request.send();
      var response = await http.Response.fromStream(streamed);

      print("===== رد السيرفر الخام: ${response.body}");

      // --- التعديل الجوهري هنا ---
      // نقبل الرد في حالة النجاح (200) أو في حالة وجود خطأ منطقي (422 أو 400)
      // لأننا نريد الوصول للـ JSON في كلا الحالتين
      if (streamed.statusCode >= 200 && streamed.statusCode < 300) {
        return Right(jsonDecode(response.body));
      } else if (streamed.statusCode == 422 || streamed.statusCode == 400) {
        try {
          // هنا نقوم بفك تشفير رسالة الخطأ من السيرفر وإرجاعها للكنترولر
          return Right(jsonDecode(response.body));
        } catch (e) {
          // إذا فشل فك التشفير، نرجع خطأ السيرفر
          return Left(StatusRequest.serverfailure);
        }
      } else {
        // أي خطأ آخر (مثل 500) يعتبر فشل تقني
        return Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print("❌ خطأ في الـ Crud: $e");
      return Left(StatusRequest.serverExption);
    }
  }
  Future<Either<StatusRequest, Map>> DeleteData(String linkurl) async {
    try {
      String? token = myServices.sharedPreferences.getString("token"); // ✅ هون الصح

      print("🔐 TOKEN: $token");

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
      String? token = myServices.sharedPreferences.getString("token"); // ✅ هون الصح


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