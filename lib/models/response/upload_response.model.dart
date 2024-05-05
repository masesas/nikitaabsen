class UploadResponse {
  String? id;
  int? size;
  String? contentType;

  UploadResponse({this.id, this.size, this.contentType});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['contentType'] = this.contentType;
    return data;
  }
}
