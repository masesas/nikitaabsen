import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nikitaabsen/facedetectionview.dart';
import 'package:nikitaabsen/models/location_point_model.dart';
import 'package:nikitaabsen/models/request/register_mobile.dart';
import 'package:nikitaabsen/models/response/company_response.dart';
import 'package:nikitaabsen/models/response/job_departement_response.dart';
import 'package:nikitaabsen/models/response/job_level_response.dart';
import 'package:nikitaabsen/models/schedule.dart';
import 'package:nikitaabsen/models/shifting.model.dart';
import 'package:nikitaabsen/models/user_schedule.dart';
import 'package:nikitaabsen/models/workday.dart';
import 'package:nikitaabsen/services/upload.service.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/request/login_request.dart';
import '../models/response/login_response.dart';
import '../models/user.model.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../services/auth.service.dart';

const String FIRST_LOGIN = 'first_login';

class AuthController extends GetxController {
  var error = false.obs;
  var done = false.obs;
  var message = ''.obs;
  var loading = false.obs;
  var loginModel = LoginModel().obs;

  setLoading(bool value) {
    loading.value = value;
  }

  setErrorAndMessage(bool value, String errorMsg) {
    error.value = value;
    message.value = errorMsg;
  }

  setDoneMessage(bool value, String doneMsg) {
    done.value = value;
    message.value = doneMsg;
  }

  void catchError(e) {
    if (e is DioError) {
      if (e.response?.data != null) {
        setLoading(false);
        setErrorAndMessage(true, e.response!.data['message']);
        EasyLoading.showError(e.response!.data['message']);
        return;
      }
      setErrorAndMessage(false, "");
      EasyLoading.showError("Terjadi kesalahan pada server");
      setLoading(false);
      return;
    }
    setErrorAndMessage(false, "");
    EasyLoading.showError("Mohon cek koneksi internet anda");
    setLoading(false);
    return;
  }

  Future<void> handleLogout() async {
    final db = await createDB();
    await db.delete('person');

    final box = GetStorage();
    await box.erase();
    Get.deleteAll();
    Get.offAll(const LoginScreen());
  }

  Future<void> handleLogin(LoginRequest loginRequest) async {
    setLoading(true);
    try {
      var response = await AuthService().login(loginRequest);
      if (response != null) {
        var user = jsonEncode(response.user);
        var accessToken = response.accessToken;

        final box = GetStorage();
        await box.write('user', user);
        await box.write('token', accessToken);

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(FIRST_LOGIN, true);

        Get.off(const HomeScreen());

        setLoading(false);
      }
    } catch (e) {
      catchError(e);
    }
  }

  Future<void> register(String fullname, String email, String password,
      String company_code, XFile file) async {
    setLoading(true);
    try {
      final uploadFormData = dio.FormData.fromMap({
        'image': await AppUtils.createMultipart(file.path),
      });

      final uploadId = await UploadService().create(uploadFormData);

      final dataRegis = DataRegister(
        fullname: fullname,
        email: email,
        password: password,
        companyCode: company_code,
        isMobile: true,
        photo: uploadId,
      );

      await AuthService().registerMobile(dataRegis);
      EasyLoading.showSuccess('Pendaftaran berhasil dikirim!');
      setLoading(false);
      Get.back();
      return;
    } catch (e) {
      setLoading(false);
      if (e is dio.DioError) {
        var message =
            e.response?.data?['message'] ?? 'Terjadi kesalahan pada server';

        EasyLoading.showError(message);

        return;
      }
      EasyLoading.showError('Terjadi kesalahan pada server');
      return;
    }
  }

  // ignore: unused_element
  void _backupDummy() {
    /*  final accessToken = AppUtils.generateRandomString();
      final companyId = AppUtils.generateRandomString(10);
      final jobDepartementId = AppUtils.generateRandomString(10);
      final jobLevelId = AppUtils.generateRandomString(10);
      final locPointId = AppUtils.generateRandomString(10);
      final userId = AppUtils.generateRandomString(10);

      final userObj = User(
        id: userId,
        company: Company(
          id: companyId,
          companyCode: "NIKITA",
          industry: "IT",
          name: "Nikita",
        ),
        companyId: companyId,
        fullname: "Pak Bram",
        email: "pTqzB@example.com",
        jobDepartement: JobDepartement(
          companyId: companyId,
          id: jobDepartementId,
          name: "Software",
        ),
        jobLevel: JobLevel(
          companyId: companyId,
          id: jobLevelId,
          level: 1,
          name: "Senior",
        ),
        employeeTypeId: AppUtils.generateRandomString(10),
        photo: 'https://placehold.co/400x400',
        isVerified: true,
        createdAt: DateTime.now().toIso8601String(),
        googleId: AppUtils.generateRandomString(10),
        hierarchyLevel: 1,
        jobDepartementId: jobDepartementId,
        jobLevelId: jobLevelId,
        jobPositionId: AppUtils.generateRandomString(10),
        locationPoint: LocationPointModel(
          companyId: companyId,
          id: locPointId,
          createdAt: DateTime.now().toIso8601String(),
          description: 'This is location point description',
          latitude: '-6.5107069',
          longitude: '106.831651',
          name: 'Home',
        ),
        nik: AppUtils.generateRandomString(10),
        locationPointId: locPointId,
        /*  shifting: Shifting(
          companyId: companyId,
          name: 'PAGI',
          from: 'MALAM',
          id: AppUtils.generateRandomString(10),
          to: 'PAGI',
        ), */
        verifyToken: accessToken,
        /* userSchedule: UserSchedule(
          userId: userId,
          schedule: Schedule(
            companyId: companyId,
            effectiveDate: DateTime.now().toIso8601String(),
            id: userId,
            type: 'Shift',
            name: 'Shift',
            workday: [
              Workday(
                id: userId,
                day: 'Senin',
                scheduleId: userId,
              ),
            ],
          ),
        ), */
      );

      final user = jsonEncode(userObj.toJson());
 */
  }
}
