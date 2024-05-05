import '../schedule.dart';

class ScheduleResponse {
  int? total;
  int? limit;
  int? skip;
  List<Schedule>? data;

  ScheduleResponse({this.total, this.limit, this.skip, this.data});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = <Schedule>[];
      json['data'].forEach((v) {
        data!.add(Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['skip'] = skip;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
