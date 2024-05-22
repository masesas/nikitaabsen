import 'dart:convert';

import '../api/main.dart';
import '../models/response/activity_response.dart';
import '../utils/status_activity.dart';

class ActivityService {
  static ActivityService? _instance;
  factory ActivityService() => _instance ??= ActivityService._();
  ActivityService._();

  Future<List<Map<String, dynamic>>> find(
    StatusActivity activity, {
    Map<String, dynamic>? params,
  }) async {
    try {
       final copy = params ?? {};
      copy['status'] = activity.name.toString();

      final res = await Api().dio.get("/api.getdata", queryParameters: copy);
      final data = jsonDecode(res.data);

      final list =
          List<Map<String, dynamic>>.from(data['data']).map((e) => e).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
