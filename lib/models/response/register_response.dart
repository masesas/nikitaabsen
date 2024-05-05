class ResponseRegister {
  String? id;
  String? fullname;
  String? email;
  bool? isMobile;
  String? photo;
  String? updatedAt;
  String? createdAt;
  int? hierarchyLevel;

  ResponseRegister(
      {this.id,
      this.fullname,
      this.email,
      this.isMobile,
      this.photo,
      this.updatedAt,
      this.createdAt,
      this.hierarchyLevel});

  ResponseRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    isMobile = json['is_mobile'];
    photo = json['photo'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    hierarchyLevel = json['hierarchy_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['is_mobile'] = this.isMobile;
    data['photo'] = this.photo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['hierarchy_level'] = this.hierarchyLevel;
    return data;
  }
}
