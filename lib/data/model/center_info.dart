import 'package:patientapp/data/model/work_houre.dart';

class CenterInfo {
  int? id;
  String? location;
  String? addressOnMap;
  String? branches;
  String? services;
  String? contact;

  List<WorkingHour>? workingHours;

  CenterInfo({
    this.id,
    this.location,
    this.addressOnMap,
    this.branches,
    this.services,
    this.contact,
    this.workingHours,
  });

  CenterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    addressOnMap = json['address_on_map'];
    branches = json['branches'];
    services = json['services'];
    contact = json['contact'];

    if (json['working_hours'] != null) {
      workingHours = <WorkingHour>[];

      json['working_hours'].forEach((v) {
        workingHours!.add(WorkingHour.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'address_on_map': addressOnMap,
      'branches': branches,
      'services': services,
      'contact': contact,
      'working_hours':
      workingHours?.map((e) => e.toJson()).toList(),
    };
  }
}