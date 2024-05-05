import '../api/main.dart';
import '../models/response/leave_type_response.dart';
import '../utils/app_utils.dart';

class LeaveTypeService {
  static LeaveTypeService? _instance;
  factory LeaveTypeService() => _instance ??= LeaveTypeService._();
  LeaveTypeService._();

  Future<LeaveTypeResponse> find(Map<String, dynamic> params) async {
    var user = AppUtils.getUser();
    params.addAll({'company_id': user.companyId});
    final res = await Api().dio.get("/leave-type", queryParameters: params);
    var leaveType = LeaveTypeResponse.fromJson(res.data);
    return leaveType;
  }
}
