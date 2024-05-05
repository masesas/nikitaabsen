import 'dart:convert';

import 'package:nikitaabsen/api/main.dart';
import 'package:nikitaabsen/models/request/approve_absen_request.dart';
import 'package:nikitaabsen/models/request/reject_absen_request.dart';
import 'package:nikitaabsen/models/response/approval_absen_response.dart';
import 'package:nikitaabsen/models/response/request_activity_response.model.dart';

class ApprovalService {
  static ApprovalService? _instance;
  factory ApprovalService() => _instance ??= ApprovalService._();
  ApprovalService._();

  Future<ApprovalAbsenResponse> approveAbsen(ApproveAbsenRequest param) async {
    var data = param.toJson();
    final res = await Api().dio.post("/approval", data: data);
    var approveAbsenResponse = ApprovalAbsenResponse.fromJson(res.data);
    return approveAbsenResponse;
  }

  Future<ApprovalAbsenResponse> rejectAbsen(RejectAbsenApproval param) async {
    var data = param.toJson();
    print('ss $data');
    final res = await Api().dio.post("/approval", data: data);
    var approveAbsenResponse = ApprovalAbsenResponse.fromJson(res.data);
    return approveAbsenResponse;
  }
}
