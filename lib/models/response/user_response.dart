import 'package:nikitaabsen/models/user.model.dart';

class UserResponse {
  int? total;
  int? limit;
  int? skip;
  List<User>? data;

  UserResponse({this.total, this.limit, this.skip, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['skip'] = skip;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
