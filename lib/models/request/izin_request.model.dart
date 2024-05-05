class IzinRequest {
  String? requestType;
  String? leaveTypeId;
  String? userId;
  String? leavePeriodFrom;
  String? leavePeriodTo;
  String? leaveNote;

  IzinRequest(
      {this.requestType,
      this.leaveTypeId,
      this.userId,
      this.leavePeriodFrom,
      this.leavePeriodTo,
      this.leaveNote});

  IzinRequest.fromJson(Map<String, dynamic> json) {
    requestType = json['request_type'];
    leaveTypeId = json['leave_type_id'];
    userId = json['user_id'];
    leavePeriodFrom = json['leave_period_from'];
    leavePeriodTo = json['leave_period_to'];
    leaveNote = json['leave_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_type'] = this.requestType;
    data['leave_type_id'] = this.leaveTypeId;
    data['user_id'] = this.userId;
    data['leave_period_from'] = this.leavePeriodFrom;
    data['leave_period_to'] = this.leavePeriodTo;
    data['leave_note'] = this.leaveNote;
    return data;
  }
}
