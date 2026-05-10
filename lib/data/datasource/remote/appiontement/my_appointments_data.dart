import '../../../../../../core/class/crud.dart';
import '../../../../../../link_api.dart';

class MyAppointmentsData {
  Crud crud;

  MyAppointmentsData(this.crud);

  getAppointments() async {
    var response = await crud.getData(
      AppLink.myAppointments,
    );

    return response.fold((l) => l, (r) => r);
  }
}