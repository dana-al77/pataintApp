
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
   // experienceYears = json['experience_years'];
    experienceYears = json['years_of_experience'];
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