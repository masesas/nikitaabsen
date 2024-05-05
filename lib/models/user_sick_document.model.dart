class UserSickDocument {
  String? id;
  String? activityId;
  String? document;

  UserSickDocument({this.id, this.activityId, this.document});

  UserSickDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activity_id'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_id'] = this.activityId;
    data['document'] = this.document;
    return data;
  }
}
