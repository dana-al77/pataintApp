import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class DoctorData {
  Crud crud;
  DoctorData(this.crud);

  get() async {
    var response = await crud.getData(AppLink.getDoctors);
    return response.fold((l) => l, (r) => r);
  }
}