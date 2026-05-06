import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class MedicalTestData {
  Crud crud;

  MedicalTestData(this.crud);

  postData({
  //  required String medicalRecordId,
    required String testType,
    required String notes,
    required File file,
  }) async {

    var response = await crud.postDataWithFileAndToken(
      AppLink.upLoadMedical,
      {
        //"medical_record_id": medicalRecordId,
        "test_type": testType,
        "notes": notes,
      },
      file,
      "file", // 👈 نفس اسم الحقل بالبوستمان
    );

    return response.fold((l) => l, (r) => r);
  }
}