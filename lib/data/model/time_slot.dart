class TimeSlot {
  String? startTime;
  String? endTime;

  TimeSlot({this.startTime, this.endTime});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
}