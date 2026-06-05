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
  String? gender;
  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.status,
    this.role,
    this.profileImage,
    this.patient,
    this.phone,
    this.gender,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    role = json['role'];
    profileImage = json['profile_image'];
    phone =json['phone'];
    gender=json['gender'];
    patient = json['patient'] != null
        ? PatientModel.fromJson(json['patient'])
        : null;
  }
}