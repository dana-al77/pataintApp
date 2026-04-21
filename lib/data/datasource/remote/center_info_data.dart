
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class CenterInfoData{

  Crud crud;

  CenterInfoData(this.crud);



  get() async {
    var response = await crud.getData("${AppLink.getCenterinfo}");

    return response.fold((l) => l, (r) => r);

  }
}