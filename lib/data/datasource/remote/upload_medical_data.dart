import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

// class MedicalTestData {
//   Crud crud;
//
//   MedicalTestData(this.crud);
//
//   postData({
//     required String testType,
//     required String notes,
//     required List<File> files
//   }) async {
//
//     var response = await crud.postDataUpLoad(
//       AppLink.upLoadMedical,
//       {
//         "test_type": testType,
//         "notes": notes,
//       },
//       files,
//       "files[]", // 👈 نفس اسم الحقل بالبوستمان
//     );
//
//     return response.fold((l) => l, (r) => r);
//   }
// }
class MedicalTestData {
  Crud crud;
  MedicalTestData(this.crud);

  postData({required String testType, required String notes, required List<File> files}) async {
    var response = await crud.postDataUpLoad(
      AppLink.upLoadMedical,
      {"test_type": testType, "notes": notes},
      files,
      "files[]",
    );

    // التغيير هنا: بدلاً من استخدام fold لإرجاع الـ Enum،
    // أعد الـ response كما هو (الذي هو Either<StatusRequest, Map>)
    return response;
  }
}