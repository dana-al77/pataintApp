import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class MedicalTestData {
  Crud crud;

  MedicalTestData(this.crud);

  postData({
    required String testType,
    required String notes,
    required List<File> files
  }) async {

    var response = await crud.postDataUpLoad(
      AppLink.upLoadMedical,
      {
        "test_type": testType,
        "notes": notes,
      },
      files,
      "files[]", // 👈 نفس اسم الحقل بالبوستمان
    );

    return response.fold((l) => l, (r) => r);
  }
}