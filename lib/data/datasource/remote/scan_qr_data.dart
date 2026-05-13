import '../../../../core/class/crud.dart';

class ScanQrData {

  Crud crud;

  ScanQrData(this.crud);

  getMedicalRecord(String url) async {

    var response =
    await crud.getData(url);

    return response.fold(
          (l) => l,
          (r) => r,
    );
  }
}