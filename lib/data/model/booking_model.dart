class BookingModel {
  String? doctorId;
  int? patientId;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? id;

  BookingModel({
    this.doctorId,
    this.patientId,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }
}