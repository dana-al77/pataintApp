
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class MedicalTips{

  Crud crud;

  MedicalTips(this.crud);



  get() async {
    var response = await crud.getData("${AppLink.getMedicalTps}");

    return response.fold((l) => l, (r) => r);

  }
}