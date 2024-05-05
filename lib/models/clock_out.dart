class ClockOut {
  String? requestType;
  String? userId;

  ClockOut({this.requestType, this.userId});

  ClockOut.fromJson(Map<String, dynamic> json) {
    requestType = json['request_type'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_type'] = this.requestType;
    data['user_id'] = this.userId;
    return data;
  }
}
