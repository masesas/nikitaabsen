class overtimeRequest {
  String? requestType;
  String? userId;
  String? overtimeDateTo;
  String? overtimeNote;

  overtimeRequest(
      {this.requestType, this.userId, this.overtimeDateTo, this.overtimeNote});

  overtimeRequest.fromJson(Map<String, dynamic> json) {
    requestType = json['request_type'];
    userId = json['user_id'];
    overtimeDateTo = json['overtime_date_to'];
    overtimeNote = json['overtime_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_type'] = this.requestType;
    data['user_id'] = this.userId;
    data['overtime_date_to'] = this.overtimeDateTo;
    data['overtime_note'] = this.overtimeNote;
    return data;
  }
}
