import 'package:nikitaabsen/models/response/company_response.dart';

class RadiusModel {
  String? companyId;
  int? maxRadius;
  bool? isSelfieIn;
  bool? isSelfieOut;
  String? createdAt;
  String? updatedAt;
  Company? company;

  RadiusModel(
      {this.companyId,
      this.maxRadius,
      this.isSelfieIn,
      this.isSelfieOut,
      this.createdAt,
      this.updatedAt,
      this.company});

  RadiusModel.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    maxRadius = json['max_radius'];
    isSelfieIn = json['is_selfie_in'];
    isSelfieOut = json['is_selfie_out'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['max_radius'] = this.maxRadius;
    data['is_selfie_in'] = this.isSelfieIn;
    data['is_selfie_out'] = this.isSelfieOut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}
