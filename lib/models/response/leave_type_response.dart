import '../leave_type.dart';

class LeaveTypeResponse {
  int? total;
  int? limit;
  int? skip;
  List<LeaveType>? data;

  LeaveTypeResponse({this.total, this.limit, this.skip, this.data});

  LeaveTypeResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = <LeaveType>[];
      json['data'].forEach((v) {
        data!.add(new LeaveType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['skip'] = this.skip;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
