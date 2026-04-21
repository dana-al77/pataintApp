class ScheduleModel {
  String? date;
  String? day;
  String? startTime;
  String? endTime;

  ScheduleModel({
    this.date,
    this.day,
    this.startTime,
    this.endTime,
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
}