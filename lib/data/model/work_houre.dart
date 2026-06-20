class WorkingHour {
  int? id;
  String? day;
  String? startTime;
  String? endTime;
  bool? isClosed;

  WorkingHour({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.isClosed,
  });

  WorkingHour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isClosed = json['is_closed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'is_closed': isClosed,
    };
  }
}