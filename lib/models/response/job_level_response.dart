class JobLevel {
  String? id;
  String? name;
  String? companyId;
  int? level;

  JobLevel({this.id, this.name, this.companyId, this.level});

  JobLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    data['company_id'] = companyId;
    return data;
  }
}
