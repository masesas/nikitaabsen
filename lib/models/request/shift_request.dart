class ShiftingRequest {
  String? companyId;
  String? name;
  String? from;
  String? to;

  ShiftingRequest({this.companyId, this.name, this.from, this.to});

  ShiftingRequest.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    name = json['name'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['name'] = name;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
