// class DoctorModel {
//   int? id;
//   String? name;
//   String? email;
//   String? specialization;
//   int? yearsOfExperience;
//   String? licenseNumber;
//   String? bio;
//   String? department;
//
//   DoctorModel({
//     this.id,
//     this.name,
//     this.email,
//     this.specialization,
//     this.yearsOfExperience,
//     this.licenseNumber,
//     this.bio,
//     this.department,
//   });
//
//   DoctorModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     specialization = json['specialization'];
//     yearsOfExperience = json['years_of_experience'];
//     licenseNumber = json['license_number'];
//     bio = json['bio'];
//     department = json['department'];
//   }
// }
import 'package:patientapp/data/model/schedula.dart';

class DoctorModel {
  int? doctorId;
  String? name;
  String? email;
  String? phone;
  String? specialization;
  int? experienceYears;
  String? bio;
  double? price;
  String? image;
  List<ScheduleModel>? schedules;

  DoctorModel({
    this.doctorId,
    this.name,
    this.email,
    this.phone,
    this.specialization,
    this.experienceYears,
    this.bio,
    this.price,
    this.image,
    this.schedules,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    specialization = json['specialization'];
    experienceYears = json['experience_years'];
    bio = json['bio'];
    price = json['price'] != null ? json['price'].toDouble() : null;
    image = json['image'];

    if (json['schedules'] != null) {
      schedules = <ScheduleModel>[];
      json['schedules'].forEach((v) {
        schedules!.add(ScheduleModel.fromJson(v));
      });
    }
  }
}