import 'location_point_model.dart';
import 'response/company_response.dart';
import 'response/job_departement_response.dart';
import 'response/job_level_response.dart';
import 'shifting.model.dart';
import 'user_schedule.dart';

class User {
  String? id;
  String? nik;
  String? uplinerId;
  String? photo;
  String? fullname;
  String? email;
  String? roleId;
  String? googleId;
  String? employeeTypeId;
  int? resetAttempts;
  String? verifyToken;
  String? verifyShortToken;
  bool? isVerified;
  String? verifyExpires;
  String? resetToken;
  String? resetShortToken;
  String? resetExpires;
  String? locationPointId;
  String? shiftingId;
  String? jobLevelId;
  String? companyId;
  String? jobDepartementId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? hierarchyLevel;
  String? jobPositionId;
  JobLevel? jobLevel;
  Company? company;
  LocationPointModel? locationPoint;
  JobDepartement? jobDepartement;
  Shifting? shifting;
  UserSchedule? userSchedule;

  User(
      {this.id,
      this.nik,
      this.uplinerId,
      this.photo,
      this.fullname,
      this.email,
      this.roleId,
      this.googleId,
      this.employeeTypeId,
      this.resetAttempts,
      this.verifyToken,
      this.verifyShortToken,
      this.isVerified,
      this.verifyExpires,
      this.resetToken,
      this.resetShortToken,
      this.resetExpires,
      this.locationPointId,
      this.shiftingId,
      this.jobLevelId,
      this.companyId,
      this.jobDepartementId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.hierarchyLevel,
      this.jobPositionId,
      this.jobLevel,
      this.company,
      this.locationPoint,
      this.jobDepartement,
      this.shifting,
      this.userSchedule});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    uplinerId = json['upliner_id'];
    photo = json['photo'];
    fullname = json['fullname'];
    email = json['email'];
    roleId = json['role_id'];
    googleId = json['googleId'];
    employeeTypeId = json['employee_type_id'];
    resetAttempts = json['resetAttempts'];
    verifyToken = json['verifyToken'];
    verifyShortToken = json['verifyShortToken'];
    isVerified = json['isVerified'];
    verifyExpires = json['verifyExpires'];
    resetToken = json['resetToken'];
    resetShortToken = json['resetShortToken'];
    resetExpires = json['resetExpires'];
    locationPointId = json['location_point_id'];
    shiftingId = json['shifting_id'];
    jobLevelId = json['job_level_id'];
    companyId = json['company_id'];
    jobDepartementId = json['job_departement_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    hierarchyLevel = json['hierarchy_level'];
    jobPositionId = json['job_position_id'];
    locationPoint = json['location_point'] != null
        ? LocationPointModel.fromJson(json['location_point'])
        : null;
    jobLevel =
        json['job_level'] != null ? JobLevel.fromJson(json['job_level']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    jobDepartement = json['job_departement'] != null
        ? JobDepartement.fromJson(json['job_departement'])
        : null;
    shifting =
        json['shifting'] != null ? Shifting.fromJson(json['shifting']) : null;
    userSchedule = json['user_schedule'] != null
        ? UserSchedule.fromJson(json['user_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nik'] = nik;
    data['upliner_id'] = uplinerId;
    data['photo'] = photo;
    data['fullname'] = fullname;
    data['email'] = email;
    data['role_id'] = roleId;
    data['googleId'] = googleId;
    data['employee_type_id'] = employeeTypeId;
    data['resetAttempts'] = resetAttempts;
    data['verifyToken'] = verifyToken;
    data['verifyShortToken'] = verifyShortToken;
    data['isVerified'] = isVerified;
    data['verifyExpires'] = verifyExpires;
    data['resetToken'] = resetToken;
    data['resetShortToken'] = resetShortToken;
    data['resetExpires'] = resetExpires;
    data['location_point_id'] = locationPointId;
    data['shifting_id'] = shiftingId;
    data['job_level_id'] = jobLevelId;
    data['company_id'] = companyId;
    data['job_departement_id'] = jobDepartementId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['hierarchy_level'] = hierarchyLevel;
    data['job_position_id'] = jobPositionId;
    if (locationPoint != null) {
      data['location_point'] = locationPoint!.toJson();
    }
    if (jobLevel != null) {
      data['job_level'] = jobLevel!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (shifting != null) {
      data['shifting'] = shifting!.toJson();
    }
    if (jobDepartement != null) {
      data['job_departement'] = jobDepartement!.toJson();
    }
    if (userSchedule != null) {
      data['user_schedule'] = userSchedule!.toJson();
    }
    return data;
  }


  
}
