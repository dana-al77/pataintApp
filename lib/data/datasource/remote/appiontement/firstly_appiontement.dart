import 'package:patientapp/link_api.dart';

import '../../../../../../../core/class/crud.dart';

class FistAppiontData {
  Crud crud;

  FistAppiontData(this.crud);

  postData({
    required String chronicDiseases,
    required String allergies,
    required String medications,
    required String notes,
    required String isSmoker,
    required String height,
    required String weight,
    required String bloodType,
    required String surgeries,
    required String familyHistory,
    required String bloodPressure,
    required String amount,
    required String maritalStatus,
    required String numberOfChildren,
  }) async {
    var response = await crud.PostDataWithToken(
      AppLink.firstAppiont,
      {
        "chronic_diseases": chronicDiseases,
        "allergies": allergies,
        "medications": medications,
        "notes": notes,
        "is_smoker": isSmoker,
        "height": height,
        "weight": weight,
        "blood_type": bloodType,
        "surgeries": surgeries,
        "family_history": familyHistory,
        "blood_pressure": bloodPressure,
        "amount": amount,
        "marital_status": maritalStatus,
        "number_of_children": numberOfChildren,

      },
    );

    return response.fold((l) => l, (r) => r);
  }
}