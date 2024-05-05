import 'package:nikitaabsen/models/user.model.dart';
import 'package:nikitaabsen/models/user_sick_document.model.dart';

class Activity {
  String? id;
  String? userId;
  String? timeIn;
  String? timeOut;
  String? overtimeIn;
  String? overtimeOut;
  String? status;
  String? notes;
  bool? isApproved;
  bool? isApprovedIn;
  bool? isVerified;
  String? checkInPhoto;
  String? izinRequestDate;
  String? sickRequestDate;
  String? overtimeRequestDate;
  String? overtimeDateTo;
  String? overtimeNote;
  bool? isApprovedIzin;
  bool? isApprovedOvertime;
  String? rejectReasonIzin;
  String? rejectReasonOvertime;
  String? longitude;
  String? latitude;
  String? leavePeriodFrom;
  String? leavePeriodTo;
  String? leaveNote;
  bool? isApprovedLeave;
  String? sickRequestDateFrom;
  String? sickRequestDateTo;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<UserSickDocument>? userSickDocument;

  Activity(
      {this.id,
      this.userId,
      this.timeIn,
      this.timeOut,
      this.overtimeIn,
      this.overtimeOut,
      this.status,
      this.notes,
      this.isApproved,
      this.isApprovedIn,
      this.isVerified,
      this.checkInPhoto,
      this.izinRequestDate,
      this.sickRequestDate,
      this.overtimeRequestDate,
      this.overtimeDateTo,
      this.isApprovedIzin,
      this.isApprovedOvertime,
      this.rejectReasonIzin,
      this.rejectReasonOvertime,
      this.longitude,
      this.latitude,
      this.leavePeriodTo,
      this.leavePeriodFrom,
      this.leaveNote,
      this.overtimeNote,
      this.isApprovedLeave,
      this.sickRequestDateFrom,
      this.sickRequestDateTo,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.userSickDocument});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    overtimeIn = json['overtime_in'];
    overtimeOut = json['overtime_out'];
    status = json['status'];
    notes = json['notes'];
    isApproved = json['is_approved'];
    isApprovedIn = json['is_approved_in'];
    isVerified = json['is_verified'];
    checkInPhoto = json['check_in_photo'];
    izinRequestDate = json['izin_request_date'];
    sickRequestDate = json['sick_request_date'];
    overtimeRequestDate = json['overtime_request_date'];
    overtimeDateTo = json['overtime_date_to'];
    overtimeNote = json['overtime_note'];
    isApprovedIzin = json['is_approved_izin'];
    isApprovedOvertime = json['is_approved_overtime'];
    rejectReasonIzin = json['reject_reason_izin'];
    rejectReasonOvertime = json['reject_reason_overtime'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    leavePeriodTo = json['leave_period_to'];
    leavePeriodFrom = json['leave_period_from'];
    leaveNote = json['leave_note'];
    isApprovedLeave = json['is_approved_leave'];
    sickRequestDateFrom = json['sick_request_date_from'];
    sickRequestDateTo = json['sick_request_date_to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['user_sick_document'] != null) {
      userSickDocument = <UserSickDocument>[];
      json['user_sick_document'].forEach((v) {
        userSickDocument!.add(UserSickDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['time_in'] = timeIn;
    data['time_out'] = timeOut;
    data['overtime_in'] = overtimeIn;
    data['overtime_out'] = overtimeOut;
    data['status'] = status;
    data['notes'] = notes;
    data['is_approved'] = isApproved;
    data['is_approved_in'] = isApprovedIn;
    data['is_verified'] = isVerified;
    data['check_in_photo'] = checkInPhoto;
    data['izin_request_date'] = izinRequestDate;
    data['sick_request_date'] = sickRequestDate;
    data['overtime_request_date'] = overtimeRequestDate;
    data['overtime_date_to'] = overtimeDateTo;
    data['is_approved_izin'] = isApprovedIzin;
    data['is_approved_overtime'] = isApprovedOvertime;
    data['overtime_note'] = overtimeNote;
    data['reject_reason_izin'] = rejectReasonIzin;
    data['reject_reason_overtime'] = rejectReasonOvertime;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['leave_period_from'] = leavePeriodFrom;
    data['leave_period_to'] = leavePeriodTo;
    data['leave_note'] = leaveNote;
    data['is_approved_leave'] = isApprovedLeave;
    data['sick_request_date_from'] = sickRequestDateFrom;
    data['sick_request_date_to'] = sickRequestDateTo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (userSickDocument != null) {
      data['user_sick_document'] =
          userSickDocument!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
