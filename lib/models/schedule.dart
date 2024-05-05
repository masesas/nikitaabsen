import 'workday.dart';

class Schedule {
  String? id;
  String? name;
  String? companyId;
  String? type;
  String? effectiveDate;
  String? createdAt;
  String? updatedAt;
  String? scheduleId;
  List<Workday>? workday;

  Schedule(
      {this.id,
      this.name,
      this.companyId,
      this.type,
      this.effectiveDate,
      this.createdAt,
      this.updatedAt,
      this.scheduleId,
      this.workday});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    type = json['type'];
    effectiveDate = json['effective_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scheduleId = json['schedule_id'];
    if (json['workday'] != null) {
      workday = <Workday>[];
      json['workday'].forEach((v) {
        workday!.add(Workday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['company_id'] = companyId;
    data['type'] = type;
    data['effective_date'] = effectiveDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['schedule_id'] = scheduleId;
    if (workday != null) {
      data['workday'] = workday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
