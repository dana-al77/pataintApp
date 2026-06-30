import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class ConsultationPaymentData {
  Crud crud;

  ConsultationPaymentData(this.crud);

  createPayment(int consultantId) async {
    var response =
    await crud.PostDataWithToken(
      AppLink.createConsultationPayment,
      {
        "consultant_id": consultantId.toString(),
        "lang": "ar",
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}