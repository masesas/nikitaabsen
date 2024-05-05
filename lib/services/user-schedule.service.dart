import 'dart:convert';

import '../api/main.dart';
import '../models/user_schedule.dart';

class UserScheduleService {
  static UserScheduleService? _instance;
  factory UserScheduleService() => _instance ??= UserScheduleService._();
  UserScheduleService._();

  Future<void> create(List<UserSchedule> data) async {
    var body = jsonEncode(data.map((e) => e.toJson()).toList());
    await Api().dio.post("/save-user-schedule", data: body);
  }
}
