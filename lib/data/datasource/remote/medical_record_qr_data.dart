
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class MedicalQrData {
  Crud crud;

  MedicalQrData(this.crud);

  getMedicalQr() async {
    var response = await crud.getData(
      AppLink.getMedicalQr,
    );

    return response.fold((l) => l, (r) => r);
  }
}