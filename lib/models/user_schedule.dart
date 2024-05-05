import 'schedule.dart';

class UserSchedule {
  String? userId;
  String? scheduleId;
  String? createdAt;
  String? updatedAt;
  Schedule? schedule;

  UserSchedule(
      {this.userId,
      this.scheduleId,
      this.createdAt,
      this.updatedAt,
      this.schedule});

  UserSchedule.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    scheduleId = json['schedule_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['schedule_id'] = scheduleId;
    if (data['created_at'] != null) {
      data['created_at'] = createdAt;
    }
    if (data['updated_at'] != null) {
      data['updated_at'] = createdAt;
    }
    if (schedule != null) {
      data['schedule'] = schedule!.toJson();
    }
    return data;
  }
}
