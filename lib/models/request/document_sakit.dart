class UserSickDocument {
  String? document;

  UserSickDocument({this.document});

  UserSickDocument.fromJson(Map<String, dynamic> json) {
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document'] = this.document;
    return data;
  }
}
