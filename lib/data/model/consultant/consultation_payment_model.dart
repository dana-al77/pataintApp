class ConsultationPaymentModel {
  int? consultationId;
  String? paymentUrl;
  String? paymentId;

  ConsultationPaymentModel({
    this.consultationId,
    this.paymentUrl,
    this.paymentId,
  });

  ConsultationPaymentModel.fromJson(Map<String, dynamic> json) {
    consultationId = json['consultation_id'];
    paymentUrl = json['payment_url'];
    paymentId = json['payment_id'];
  }
}