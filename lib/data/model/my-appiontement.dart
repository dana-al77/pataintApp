class MyAppointmentModel {
  int? id;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  String? paymentId;
  String? doctorName;
  String? specialization;
  String? doctorImage;

  MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    paymentId = json['payment_id'];
    doctorName = json['doctor']?['user']?['name'];
    specialization = json['doctor']?['specialization'];
    doctorImage = json['doctor']?['user']?['profile_image'];
  }
}