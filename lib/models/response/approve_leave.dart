class approvalLeaveResponse {
  String? activityType;
  String? activityId;
  bool? isApproved;
  String? rejectReasonOvertime;

  approvalLeaveResponse(
      {this.activityType,
      this.activityId,
      this.isApproved,
      this.rejectReasonOvertime});

  approvalLeaveResponse.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    activityId = json['activity_id'];
    isApproved = json['is_approved'];
    rejectReasonOvertime = json['reject_reason_overtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_type'] = this.activityType;
    data['activity_id'] = this.activityId;
    data['is_approved'] = this.isApproved;
    data['reject_reason_overtime'] = this.rejectReasonOvertime;
    return data;
  }
}
