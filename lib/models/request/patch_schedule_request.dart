class PatchScheduleRequest {
  String? name;
  String? type;
  String? effectiveDate;
  String? companyId;
  List<PatchWorkday>? workday;

  PatchScheduleRequest(
      {this.name, this.type, this.effectiveDate, this.companyId, this.workday});

  PatchScheduleRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    effectiveDate = json['effective_date'];
    companyId = json['company_id'];
    if (json['workday'] != null) {
      workday = <PatchWorkday>[];
      json['workday'].forEach((v) {
        workday!.add(PatchWorkday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['effective_date'] = effectiveDate;
    data['company_id'] = companyId;
    if (workday != null) {
      data['workday'] = workday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatchWorkday {
  String? name;
  String? day;
  String? shiftingId;

  PatchWorkday({this.name, this.day, this.shiftingId});

  PatchWorkday.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    day = json['day'];
    shiftingId = json['shifting_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['day'] = day;
    data['shifting_id'] = shiftingId;
    return data;
  }
}
