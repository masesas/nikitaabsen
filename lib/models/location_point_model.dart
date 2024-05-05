class LocationPointModel {
  String? id;
  String? companyId;
  String? name;
  String? latitude;
  String? longitude;
  String? description;
  String? createdAt;
  String? updatedAt;

  LocationPointModel(
      {this.id,
      this.companyId,
      this.name,
      this.latitude,
      this.longitude,
      this.description,
      this.createdAt,
      this.updatedAt});

  LocationPointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
