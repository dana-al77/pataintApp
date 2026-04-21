import 'package:patientapp/data/model/time_slot.dart';

class AvailableSlotsModel {
  String? date;
  String? day;
  List<TimeSlot>? slots;

  AvailableSlotsModel({this.date, this.day, this.slots});

  AvailableSlotsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];

    if (json['available_slots'] != null) {
      slots = <TimeSlot>[];
      json['available_slots'].forEach((v) {
        slots!.add(TimeSlot.fromJson(v));
      });
    }
  }
}