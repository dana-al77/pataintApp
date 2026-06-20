
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
  int? patients_count;
  int? average_rating;
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
    this.patients_count,
    this.average_rating,
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
    patients_count=json['patients_count'];
    average_rating=json['average_rating'];
    if (json['schedules'] != null) {
      schedules = <ScheduleModel>[];
      json['schedules'].forEach((v) {
        schedules!.add(ScheduleModel.fromJson(v));
      });
    }
  }
}