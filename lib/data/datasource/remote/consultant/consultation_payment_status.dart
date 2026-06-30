import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ConsultationPaymentStatusData {
  Crud crud;

  ConsultationPaymentStatusData(this.crud);

  getStatus(String paymentId) async {
    var response =
    await crud.getData(
      "${AppLink.consultationPaymentStatus}/$paymentId",

    );

    return response.fold((l) => l, (r) => r);
  }
}