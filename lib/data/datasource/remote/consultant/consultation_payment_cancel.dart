import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ConsultationPaymentCancelData {
  Crud crud;

  ConsultationPaymentCancelData(this.crud);

  cancel(String paymentId) async {
    var response =
    await crud.PostDataWithToken(
      "${AppLink.consultationPaymentCancel}/$paymentId",
      {},

    );

    return response.fold((l) => l, (r) => r);
  }
}