import '../shifting.model.dart';

class ShfitingResponse {
  int? total;
  int? limit;
  int? skip;
  List<Shifting>? data;

  ShfitingResponse({this.total, this.limit, this.skip, this.data});

  ShfitingResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = <Shifting>[];
      json['data'].forEach((v) {
        data!.add(new Shifting.fromJson(v));
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
