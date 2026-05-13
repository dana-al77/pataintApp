class MedicalQrModel {
  bool? success;
  String? message;
  MedicalQr? data;

  MedicalQrModel({
    this.success,
    this.message,
    this.data,
  });

  MedicalQrModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    data = json['data'] != null
        ? MedicalQr.fromJson(json['data'])
        : null;
  }
}

class MedicalQr {
  MedicalRecord? medicalRecord;
  String? qrCodeUrl;

  MedicalQr({
    this.medicalRecord,
    this.qrCodeUrl,
  });

  MedicalQr.fromJson(Map<String, dynamic> json) {
    medicalRecord = json['medical_record'] != null
        ? MedicalRecord.fromJson(json['medical_record'])
        : null;

    qrCodeUrl = json['qr_code_url'];
  }
}

class MedicalRecord {
  int? id;
  String? patientName;
  String? bloodType;
  String? bloodPressure;
  int? height;
  int? weight;
  String? isSmoker;
  String? chronicDiseases;
  String? allergies;
  String? medications;
  String? surgeries;
  String? familyHistory;
  String? maritalStatus;
  int? numberOfChildren;
  String? notes;
  String? email;
  String? phone;
  String? gender;
  String? profileImage;
  String? dateOfBirth;
  int? age;
  String? country;
  String? city;
  String? address;
  String? emergencyContact;

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    bloodType = json['blood_type'];
    bloodPressure = json['blood_pressure'];
    height = json['height'];
    weight = json['weight'];
    isSmoker = json['is_smoker'];
    chronicDiseases = json['chronic_diseases'];
    allergies = json['allergies'];
    medications = json['medications'];
    surgeries = json['surgeries'];
    familyHistory = json['family_history'];
    maritalStatus = json['marital_status'];
    numberOfChildren = json['number_of_children'];
    notes = json['notes'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    emergencyContact = json['emergency_contact'];
  }
}