class Shifting {
  String? id;
  String? companyId;
  String? name;
  String? from;
  String? to;
  String? createdAt;
  String? updatedAt;

  Shifting(
      {this.id,
      this.companyId,
      this.name,
      this.from,
      this.to,
      this.createdAt,
      this.updatedAt});

  Shifting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    from = json['from'];
    to = json['to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['from'] = this.from;
    data['to'] = this.to;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
