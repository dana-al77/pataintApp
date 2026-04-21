
import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class SupportData{

  Crud crud;

  SupportData(this.crud);



  get() async {
    var response = await crud.getData("${AppLink.getsupport}");

    return response.fold((l) => l, (r) => r);

  }
}