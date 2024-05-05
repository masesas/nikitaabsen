class ApprovalAbsenResponse {
  String? name;
  String? message;
  int? code;
  String? className;

  ApprovalAbsenResponse({this.name, this.message, this.code, this.className});

  ApprovalAbsenResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    code = json['code'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    data['code'] = this.code;
    data['className'] = this.className;
    return data;
  }
}
