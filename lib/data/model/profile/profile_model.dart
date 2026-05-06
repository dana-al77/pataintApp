import 'package:patientapp/data/model/profile/pateint_model.dart';

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? status;
  String? role;
  String? profileImage;
  PatientModel? patient;
  String? phone;
  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.status,
    this.role,
    this.profileImage,
    this.patient,
    this.phone
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    role = json['role'];
    profileImage = json['profile_image'];

    patient = json['patient'] != null
        ? PatientModel.fromJson(json['patient'])
        : null;
  }
}