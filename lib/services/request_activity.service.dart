import 'package:nikitaabsen/models/request/izin_sakit.dart';
import 'package:nikitaabsen/models/request/overtime_request.dart';
import 'package:nikitaabsen/models/request/register_mobile.dart';

import '../api/main.dart';
import '../models/clock_in.model.dart';
import '../models/clock_out.dart';
import '../models/request/izin_request.model.dart';
import '../models/response/request_activity_response.model.dart';

class RequestActivityService {
  static RequestActivityService? _instance;
  factory RequestActivityService() => _instance ??= RequestActivityService._();
  RequestActivityService._();

  Future<RequestActivityResponse> clockIn(ClockIn data) async {
    final response = await Api().dio.post("/request-activity", data: data);
    final clockIn = RequestActivityResponse.fromJson(response.data);
    return clockIn;
  }

  Future<RequestActivityResponse> clockOut(ClockOut data) async {
    final response = await Api().dio.post("/request-activity", data: data);
    final clockIn = RequestActivityResponse.fromJson(response.data);
    return clockIn;
  }

  Future<RequestActivityResponse> izin(IzinRequest data) async {
    final response = await Api().dio.post("/request-activity", data: data);
    final izinResponse = RequestActivityResponse.fromJson(response.data);
    return izinResponse;
  }

  Future<RequestActivityResponse> overtime(overtimeRequest data) async {
    final response = await Api().dio.post("/request-activity", data: data);
    final izinResponse = RequestActivityResponse.fromJson(response.data);
    return izinResponse;
  }

  Future<RequestActivityResponse> izinSakit(DocumentSick data) async {
    final response = await Api().dio.post("/request-activity", data: data);
    final izinSakitResponse = RequestActivityResponse.fromJson(response.data);
    print(izinSakitResponse);
    return izinSakitResponse;
  }
}
