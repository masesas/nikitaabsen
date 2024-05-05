import 'shifting.model.dart';

class Workday {
  String? id;
  String? name;
  String? day;
  String? scheduleId;
  String? shiftingId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  Shifting? shifting;

  Workday(
      {this.id,
      this.name,
      this.day,
      this.scheduleId,
      this.shiftingId,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.shifting});

  Workday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    day = json['day'];
    scheduleId = json['schedule_id'];
    shiftingId = json['shifting_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shifting =
        json['shifting'] != null ? Shifting.fromJson(json['shifting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['day'] = day;
    data['schedule_id'] = scheduleId;
    data['shifting_id'] = shiftingId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (shifting != null) {
      data['shifting'] = shifting!.toJson();
    }
    return data;
  }
}
