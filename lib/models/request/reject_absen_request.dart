class RejectAbsenApproval {
  String? activityType;
  String? activityId;
  bool? isApproved;
  String? rejectReasonIn;

  RejectAbsenApproval(
      {this.activityType,
      this.activityId,
      this.isApproved,
      this.rejectReasonIn});

  RejectAbsenApproval.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    activityId = json['activity_id'];
    isApproved = json['is_approved'];
    rejectReasonIn = json['reject_reason_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_type'] = this.activityType;
    data['activity_id'] = this.activityId;
    data['is_approved'] = this.isApproved;
    data['reject_reason_in'] = this.rejectReasonIn;
    return data;
  }
}
