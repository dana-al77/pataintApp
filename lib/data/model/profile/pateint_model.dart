class PatientModel {
  String? dateOfBirth;
  String? country;
  String? city;
  String? emergencyContact;

  PatientModel({
    this.dateOfBirth,
    this.country,
    this.city,
    this.emergencyContact,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['date_of_birth'];
    country = json['country'];
    city = json['city'];
    emergencyContact = json['emergency_contact'];
  }
}