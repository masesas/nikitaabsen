class ClockIn {
  String? requestType;
  String? userId;
  String? checkInPhoto;
  String? longitude;
  String? latitude;
  String? notes;
  bool? is_wfh;

  ClockIn(
      {this.requestType,
      this.userId,
      this.checkInPhoto,
      this.longitude,
      this.latitude,
      this.notes,
      this.is_wfh});

  ClockIn.fromJson(Map<String, dynamic> json) {
    requestType = json['request_type'];
    userId = json['user_id'];
    checkInPhoto = json['check_in_photo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    notes = json['notes'];
    is_wfh = json['is_wfh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_type'] = this.requestType;
    data['user_id'] = this.userId;
    data['check_in_photo'] = this.checkInPhoto;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['notes'] = this.notes;
    data['is_wfh'] = this.is_wfh;
    return data;
  }
}
