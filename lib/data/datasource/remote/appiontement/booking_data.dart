import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class BookingData {
  final Crud crud;

  BookingData(this.crud);

  Future<dynamic> bookAppointment({
    required int doctorId,
    required String date,
    required String startTime,
    required String amount,
  }) async {
    var response = await crud.PostDataWithToken(
      AppLink.bookAppointment,
      {
        "doctor_id": doctorId.toString(),
        "date": date,
        "start_time": startTime,
        "amount": amount,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}