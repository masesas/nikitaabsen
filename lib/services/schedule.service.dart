import '../api/main.dart';
import '../models/response/schedule_response.dart';
import '../models/schedule.dart';
import '../utils/app_utils.dart';

class ScheduleService {
  static ScheduleService? _instance;
  factory ScheduleService() => _instance ??= ScheduleService._();
  ScheduleService._();

  Future<ScheduleResponse> find(Map<String, dynamic> params) async {
    var user = AppUtils.getUser();
    print(user.companyId);
    params.addAll({'company_id': user.companyId});
    final res = await Api().dio.get("/schedule", queryParameters: params);
    final schedule = ScheduleResponse.fromJson(res.data);
    return schedule;
  }

  Future<void> create(Map<String, dynamic> data) async {
    await Api().dio.post('/schedule', data: data);
  }

  Future<void> patch(String id, Map<String, dynamic> data) async {
    await Api().dio.patch('/schedule/$id', data: data);
  }

  Future<Schedule> getById(String id) async {
    final response = await Api().dio.get('/schedule/$id');
    final json = Schedule.fromJson(response.data);
    return json;
  }
}
