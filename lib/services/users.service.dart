import 'package:nikitaabsen/models/response/user_response.dart';

import '../api/main.dart';
import '../models/user.model.dart';
import '../utils/app_utils.dart';

class UsersService {
  static UsersService? _instance;
  factory UsersService() => _instance ??= UsersService._();
  UsersService._();

  Future<User> getCurrentUser() async {
    var user = AppUtils.getUser();
    final res = await Api().dio.get("/users/${user.id}");
    var userResponse = User.fromJson(res.data);
    return userResponse;
  }

  Future<UserResponse> getKaryawan({Map<String, dynamic>? params}) async {
    final res = await Api().dio.get("/users", queryParameters: params);
    var userResponse = UserResponse.fromJson(res.data);
    return userResponse;
  }
}
