class ReviewModel {
  final int id;
  final int doctorId;
  final int patientId;
  final int rating;
  final String? comment;
  final String? createAt;

  final PatientModel? patient;

  ReviewModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.rating,
    required this.createAt,
    this.comment,
    this.patient,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      rating: json['rating'] is String
          ? int.parse(json['rating'])
          : json['rating'],
      comment: json['comment'],
  createAt: json['created_at'],

      patient: json['patient'] != null
          ? PatientModel.fromJson(json['patient'])
          : null,
    );
  }
}
class PatientModel {
  final int id;
  final String name;
  final String? profileImage;

  PatientModel({
    required this.id,
    required this.name,
    this.profileImage,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      profileImage: json['profile_image'],
    );
  }
}