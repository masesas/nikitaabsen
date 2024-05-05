class ApproveAbsenRequest {
  String? activityType;
  String? activityId;
  bool? isApproved;

  ApproveAbsenRequest({this.activityType, this.activityId, this.isApproved});

  ApproveAbsenRequest.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    activityId = json['activity_id'];
    isApproved = json['is_approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_type'] = this.activityType;
    data['activity_id'] = this.activityId;
    data['is_approved'] = this.isApproved;
    return data;
  }
}
