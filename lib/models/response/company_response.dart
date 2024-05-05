class Company {
  String? id;
  String? name;
  String? industry;
  String? companyCode;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.industry,
      this.companyCode,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    industry = json['industry'];
    companyCode = json['company_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['industry'] = this.industry;
    data['company_code'] = this.companyCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
