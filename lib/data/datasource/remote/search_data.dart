import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class SearchDoctorsData {
  Crud crud;

  SearchDoctorsData(this.crud);

  getData(String search) async {
    var response = await crud.getData(
      "${AppLink.searchDoctorspec}?search=$search",
    );

    return response.fold((l) => l, (r) => r);
  }
}