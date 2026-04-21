import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class TestData{

  Crud crud;

  TestData(this.crud);

  getData() async{
    var response =await crud.PostData(AppLink.test, {});

  return response.fold((l) => l, (r) => r);
  }

}