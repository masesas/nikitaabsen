import '../api/main.dart';
import '../models/response/activity_response.dart';

class ActivityService {
  static ActivityService? _instance;
  factory ActivityService() => _instance ??= ActivityService._();
  ActivityService._();

  Future<ActivityResponse> find({Map<String, dynamic>? params}) async {
    final res = await Api().dio.get("/api.getdata", queryParameters: params);
    var loginResponse = ActivityResponse.fromJson(res.data);
    return loginResponse;
  }
}
