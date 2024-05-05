class JobDepartement {
  String? id;
  String? companyId;
  String? name;
  String? createdAt;
  String? updatedAt;

  JobDepartement(
      {this.id, this.companyId, this.name, this.createdAt, this.updatedAt});

  JobDepartement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
