import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ConsultantData {
  Crud crud;

  ConsultantData(this.crud);

  getConsultants() async {
    var response =
    await crud.getData(AppLink.consultants);

    return response.fold((l) => l, (r) => r);
  }
}