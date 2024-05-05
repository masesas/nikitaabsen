import '../models/request/shift_request.dart';

import '../api/main.dart';
import '../models/response/shifting_response.dart';
import '../utils/app_utils.dart';

class ShiftingService {
  static ShiftingService? _instance;
  factory ShiftingService() => _instance ??= ShiftingService._();
  ShiftingService._();

  Future<ShfitingResponse> find(Map<String, dynamic> params) async {
    var user = AppUtils.getUser();
    params.addAll({'company_id': user.companyId});
    final res = await Api().dio.get("/shifting", queryParameters: params);
    var shifting = ShfitingResponse.fromJson(res.data);
    return shifting;
  }

  Future<ShfitingResponse> addshift(ShiftingRequest data) async {
    final res = await Api().dio.post("/shifting", data: data);
    var shifting = ShfitingResponse.fromJson(res.data);
    return shifting;
  }

  Future editJk(var data, String id) async {
    final res = await Api().dio.patch("/shifting/$id", data: data);
    var shifting = ShfitingResponse.fromJson(res.data);
    return shifting;
  }

  Future deleteJk(String id) async {
    final res = await Api().dio.delete("/shifting/$id");
    var shifting = ShfitingResponse.fromJson(res.data);
    return shifting;
  }
}
