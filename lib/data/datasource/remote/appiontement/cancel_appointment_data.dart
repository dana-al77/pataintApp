import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class CancelAppointmentData {

  Crud crud;

  CancelAppointmentData(this.crud);

  cancelAppointment(String paymentId) async {

    var response = await crud.PostDataWithToken(
      "${AppLink.cancelPayment}/$paymentId",
      {},
    );

    return response.fold((l) => l, (r) => r);
  }
}