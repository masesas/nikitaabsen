import 'package:nikitaabsen/models/request/register_mobile.dart';
import 'package:nikitaabsen/models/response/register_response.dart';

import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

import '../api/main.dart';

class AuthService {
  static AuthService? _instance;
  factory AuthService() => _instance ??= AuthService._();
  AuthService._();

  Future<LoginModel> login(LoginRequest login) async {
    var data = login.toJson();
    final res = await Api().dio.post("/api.login", data: data);
    var loginResponse = LoginModel.fromJson(res.data);
    return loginResponse;
  }

  Future<ResponseRegister> registerMobile(DataRegister dataRegister) async {
    var data = dataRegister.toJson();
    final res = await Api().dio.post("/api.register", data: data);
    var registerResponse = ResponseRegister.fromJson(res.data);
    return registerResponse;
  }
}
