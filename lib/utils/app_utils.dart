import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nikitaabsen/models/workday.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

import '../models/activity.model.dart';
import '../models/location_point_model.dart';
import '../models/radius_model.dart';
import '../models/user.model.dart';
import '../services/app_config.service.dart';
import 'app_config.dart';

class AppUtils {
  static User getUser() {
    final box = GetStorage();
    var readUser = box.read('user');
    var user = User.fromJson(jsonDecode(readUser));
    return user;
  }

  static String getToken() {
    final box = GetStorage();
    var token = box.read('token');
    return token.toString();
  }

  static String getUrl(String filename) {
    return '${AppConfig.baseUrl}/uploads/$filename';
  }

  static LocationPointModel getLocPoint() {
    final box = GetStorage();
    var readLoc = box.read('user');
    var locp = LocationPointModel.fromJson(jsonDecode(readLoc));
    return locp;
  }

  static RadiusModel getRadius() {
    final box = GetStorage();
    var readrad = box.read('user');
    var locp = RadiusModel.fromJson(jsonDecode(readrad));
    return locp;
  }

  static String getInitials(String fullname) => fullname.isNotEmpty
      ? fullname.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  static mapActivityStatus(String status) {
    switch (status) {
      case 'IN':
        return 'Hadir';
      case 'SAKIT':
        return 'Sakit';
      case 'OVERTIME':
        return 'Lembur';
      case 'CUTI':
        return 'Cuti';
      default:
        return '-';
    }
  }

  static mapActivityStatusAll1(String status, Activity activity) {
    switch (status) {
      case 'IN':
        return activity.isApproved;
      case 'SAKIT':
        return '';
      case 'OVERTIME':
        return activity.isApprovedOvertime;
      case 'CUTI':
        return activity.isApprovedLeave;
      default:
        return 'Menunggu Approval';
    }
  }

  static mapActivityStatusAll(String status, Activity activity) {
    if (status == 'IN') {
      if (activity.isApprovedIn == null) {
        return "Menunggu Approval";
      }
      if (activity.isApprovedIn.toString() == 'false') {
        return "Tidak Di setujui";
      }
      if (activity.isApprovedIn.toString() == 'true') {
        return "Di setujui";
      }
      return;
    }
    if (status == 'SAKIT') {
      return '';
    }
    if (status == 'OVERTIME') {
      if (activity.isApprovedOvertime == null) {
        return "Menunggu Approval";
      }
      if (activity.isApprovedOvertime.toString() == 'false') {
        return 'Tidak Di setujui';
      }
      if (activity.isApprovedOvertime.toString() == 'true') {
        return 'Di setujui';
      }
      return;
    }
    if (status == 'CUTI') {
      if (activity.isApprovedLeave == null) {
        return "Menunggu Approval";
      }
      if (activity.isApprovedLeave.toString() == 'false') {
        return 'Tidak Di setujui';
      }
      if (activity.isApprovedLeave.toString() == 'true') {
        return 'Di setujui';
      }
      return;
    }
    if (status == "IZIN") {
      if (activity.isApprovedIzin == null) {
        return "Menunggu Approval";
      }
      if (activity.isApprovedIzin.toString() == 'false') {
        return 'Tidak Di setujui';
      }
      if (activity.isApprovedIzin.toString() == 'true') {
        return 'Di setujui';
      }
      return;
    }
  }

  static mapActivityNotes(String status, Activity activity) {
    switch (status) {
      case 'IN':
        return activity.notes ?? "-";
      case 'CUTI':
        return activity.leaveNote ?? "-";
      case 'OVERTIME':
        return activity.overtimeNote ?? "-";
      default:
        return "";
    }
  }

  static String leaveNote(String? leaveNOte) {
    if (leaveNOte == null) {
      return '-';
    }
    return '';
  }

  static String leaveStatus(bool? isApprovedLeave) {
    if (isApprovedLeave == null) {
      return 'Menunggu Approval';
    }
    if (isApprovedLeave) {
      return 'Di Setujui';
    }
    if (!isApprovedLeave) {
      return 'Tidak Di setujui';
    }
    return '';
  }

  static String overtimetatus(bool? isApprovedOvertime) {
    if (isApprovedOvertime == null) {
      return 'Menunggu Approval';
    }
    if (isApprovedOvertime) {
      return 'Di Setujui';
    }
    if (!isApprovedOvertime) {
      return 'Tidak Di setujui';
    }
    return '';
  }

  // static overtimenote(String overtime_note) =>
  //     overtime_note.isNotEmpty ? overtime_note : 'Tidak Mengisi Alasan';

  static String overtimenote(String? overtimeNote) {
    if (overtimeNote == null) {
      return '-';
    }
    return overtimeNote;
  }

  static String basicDateFormatter(String? date) {
    if (date == null) {
      return '-';
    }
    return DateFormat('EEE, dd MMM yyyy', 'id')
        .format(DateTime.parse(date).toLocal());
  }

  static String getIsApprovedAbsen(bool? isApproved) {
    if (isApproved == true) {
      return 'Disetujui';
    }
    if (isApproved == false) {
      return 'Di Tolak';
    }
    if (isApproved == null) {
      return 'Menunggu Disetujui';
    }

    return '';
  }

  static String basicDateFormatterNoDay(String? date) {
    if (date == null) {
      return '-';
    }
    return DateFormat('dd MMM yyyy', 'id')
        .format(DateTime.parse(date).toLocal());
  }

  static String getTimeFromDate(String? date) {
    if (date?.isEmpty ?? true) {
      return '-';
    }
    var dateFormat = DateTime.parse(date!).toLocal();
    return DateFormat('HH:mm:ss').format(dateFormat);
  }

  static Future<MultipartFile> createMultipart(String path) async {
    return await MultipartFile.fromFile(path,
        contentType: MediaType('image', 'jpeg'));
  }

  static String formatTime(String time) {
    return DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(time));
  }

  static Future<String?> hasNewVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    try {
      var response = await AppConfigService().get();
      if (response.version == null) {
        return null;
      }

      Version currentVersion = Version.parse(packageInfo.version);
      Version latestVersion = Version.parse(response.version!);

      if (latestVersion > currentVersion) {
        return null;//response.url;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static bool hasShiftingTime(String? from, String? to) {
    if (from == null || to == null) {
      return false;
    }

    return true;
  }

  static String getUserSchedule(String? selectedSchedule, User user) {
    if (selectedSchedule != null) {
      return selectedSchedule;
    }

    if (user.userSchedule?.scheduleId != null) {
      return user.userSchedule!.scheduleId!;
    }

    return '';
  }

  static String mapDays(String value) {
    switch (value) {
      case '1':
        return 'Senin';
      case '2':
        return 'Selasa';
      case '3':
        return 'Rabu';
      case '4':
        return 'Kamis';
      case '5':
        return 'Jumat';
      case '6':
        return 'Sabtu';
      case '7':
        return 'Minggu';
      default:
        return '';
    }
  }

  static String mapWorkdays(List<Workday>? workdays, String day) {
    final workday = workdays?.firstWhereOrNull((element) => element.day == day);
    if (workday == null) {
      return '';
    }
    return workday.shiftingId ?? '2';
  }

  static bool checkLevel(int? level) {
    if (level == null) {
      return false;
    }

    return level > 1;
  }

  static String generateRandomString([int length = 20]) {
  const String charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';/**!@#\$%^&*()_+ */

  Random random = Random();
  String result = '';

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    result += charset[randomIndex];
  }

  return result;
}

}
