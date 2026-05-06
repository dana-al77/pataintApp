import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class PaymentStatusData {
  Crud crud;

  PaymentStatusData(this.crud);

  getStatus(String paymentId) async {
    var response = await crud.getData(
      "${AppLink.paymentStatus}/$paymentId",

    );

    return response.fold((l) => l, (r) => r);
  }
}