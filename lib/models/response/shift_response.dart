class Shift {
  String? id;
  String? companyId;
  String? name;
  String? from;
  String? to;
  String? isHoliday;
  String? createdAt;
  String? updatedAt;

  Shift(
      {this.id,
      this.companyId,
      this.name,
      this.from,
      this.to,
      this.isHoliday,
      this.createdAt,
      this.updatedAt});

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    from = json['from'];
    to = json['to'];
    isHoliday = json['is_holiday'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['from'] = from;
    data['to'] = to;
    data['is_holiday'] = isHoliday;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
