import '../../../../core/class/crud.dart';
import '../../../../link_api.dart';

class WhatsappData {
  Crud crud;

  WhatsappData(this.crud);

  getWhatsappUrl(int consultationId) async {
    var response = await crud.getData(
      "${AppLink.whatsapp}/$consultationId",
    );

    return response.fold((l) => l, (r) => r);
  }
}