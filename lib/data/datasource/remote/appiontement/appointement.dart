import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class AppointmentData {
  Crud crud;
  AppointmentData(this.crud);

  getAvailableSlots(int doctorId, String date) async {
    var response = await crud.PostDataWithToken(
      AppLink.availableAppointments,
      {
        "doctor_id": doctorId.toString(),
        "date": date,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}