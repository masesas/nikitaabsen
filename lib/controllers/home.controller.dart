import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/login.dart';
import '../services/face.service.dart';
import '../services/users.service.dart';
import '../utils/app_config.dart';
import '../utils/app_utils.dart';
import '../utils/check_new_version.dart';

class HomeController extends GetxController {
  var user = AppUtils.getUser().obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  Future<void> init() async {
    await getCurrentUser();
    await checkNewVersion();
  }

  Future<void> handleLogout() async {
    final box = GetStorage();
    await box.erase();
    Get.deleteAll();
    Get.offAll(const LoginScreen());
  }

  Future<void> getCurrentUser() async {
    setLoading(true);
    var response = await UsersService().getCurrentUser();
    var _user = jsonEncode(response);
    final box = GetStorage();
    await box.write('user', _user);
    user.value = response;
    user.refresh();
    setLoading(false);
  }

  Future handleClockInCallback(XFile file) async {
    if (user.value.photo?.isEmpty ?? false) {
      EasyLoading.showError(
          'Foto profil belum diterapkan, silahkan hubungi administrator');
      return;
    }

    try {
      var formdata = dio.FormData.fromMap({
        'name': user.value.fullname,
        'photo': await AppUtils.createMultipart(file.path),
        'ref_photo': "${AppConfig.baseUrl}/uploads/${user.value.photo}"
      });
      final _response = await FaceService().recognize(formdata);
      if (_response.data!['_label'] == 'unknown') {
        EasyLoading.showError('Wajah tidak dikenali');
        Get.back();
        return;
      }
      EasyLoading.dismiss();
      Get.back(result: file);
    } catch (e) {
      catchRecognitionError(e);
      Get.back();
      return;
    }
  }

  void catchRecognitionError(e) {
    if (e is dio.DioError) {
      if (e.response?.data != null) {
        var message = e.response!.data['message'];
        if (message == 'no face detected') {
          message =
              'Wajah tidak terdeteksi, mohon lakukan selfie ditempat bercahaya';
          EasyLoading.showError(message);
          return;
        }
        EasyLoading.showError('Maaf terjadi kesalahan pada server');
        return;
      }
      EasyLoading.showError('Maaf terjadi kesalahan pada server');
      return;
    }
    EasyLoading.showError('Maaf terjadi kesalahan pada server');
    return;
  }

  _showLocationDialog() async {
    return Get.dialog(
      CupertinoAlertDialog(
        title: const Text(
          'Location permission are disabled, please allow the permission',
          textAlign: TextAlign.center,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text(
              'Ok',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).then((value) => Get.back());
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return _showLocationDialog();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return _showLocationDialog();
    }

    await Geolocator.getCurrentPosition();
  }
}