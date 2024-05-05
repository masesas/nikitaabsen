class AppConfigResponse {
  String? id;
  String? version;
  String? url;
  String? updatedAt;
  String? createdAt;

  AppConfigResponse({this.id, this.version, this.updatedAt, this.createdAt});

  AppConfigResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    url = json['url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['url'] = url;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
