import 'package:nikitaabsen/api/main.dart';
import 'package:nikitaabsen/models/request/reject_request.dart';

import '../models/response/approve_leave.dart';

class ApprovalService {
  static ApprovalService? _instance;
  factory ApprovalService() => _instance ??= ApprovalService._();
  ApprovalService._();

  Future<approvalLeaveResponse> leave(approvalLeaveResponse data) async {
    final response = await Api().dio.post("/approval", data: data);
    final clockIn = approvalLeaveResponse.fromJson(response.data);
    return clockIn;
  }

  Future<approvalLeaveResponse> reject(RejectApproval param) async {
    var data = param.toJson();
    print('ss $data');
    final res = await Api().dio.post("/approval", data: data);
    var reject = approvalLeaveResponse.fromJson(res.data);
    return reject;
  }
}
