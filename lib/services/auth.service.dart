import 'dart:convert';

import 'package:nikitaabsen/models/request/register_mobile.dart';
import 'package:nikitaabsen/models/response/register_response.dart';

import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

import '../api/main.dart';
import '../models/user.model.dart';

class AuthService {
  static AuthService? _instance;
  factory AuthService() => _instance ??= AuthService._();
  AuthService._();

  Future<LoginModel?> login(LoginRequest login) async {
    final json = <String, dynamic>{};
    json['phone'] = login.email;
    json['password'] = login.password;

    final res = await Api().dio.post("/api.login", queryParameters: json);
    final data = jsonDecode(res.data) as Map<String, dynamic>;
    if ((data["status"] as String?) == 'OK') {
      final LoginModel login = LoginModel();
      final User user = User();
      user.fullname = data["name"];

      if (data['icon'].toString().isNotEmpty) {
        user.photo = data['icon'];
      }

      login.accessToken = data["token"];
      login.user = user;
      return login;
    }

    throw Exception(data["message"].toString());
  }

  Future<ResponseRegister?> registerMobile(DataRegister dataRegister) async {
    final json = <String, dynamic>{};
    json['selfie'] = dataRegister.photo;
    json['name'] = dataRegister.fullname;
    json["phone"] = dataRegister.email;

    final res = await Api().dio.post("/api.register", queryParameters: json);
    final data = jsonDecode(res.data);
    if (data['status'] == 'OK') {
      final registerResponse = ResponseRegister.fromJson(data);
      return registerResponse;
    }

    throw Exception(data["message"]);
  }
}
