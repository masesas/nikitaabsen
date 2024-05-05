import '../activity.model.dart';

class ActivityResponse {
  int? total;
  int? limit;
  int? skip;
  List<Activity>? data;

  ActivityResponse({this.total, this.limit, this.skip, this.data});

  ActivityResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = <Activity>[];
      json['data'].forEach((v) {
        data!.add(new Activity.fromJson(v));
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
