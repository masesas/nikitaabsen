import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../services/face.service.dart';
import '../utils/app_config.dart';
import '../utils/app_utils.dart';

class FaceController extends GetxController {
  Future<void> handleAbsen({
    required XFile value,
    required String fullname,
    required String userPhoto,
  }) async {
    String filename = value.path.split('/').last;

    var formdata = dio.FormData.fromMap({
      'name': fullname,
      'photo': await AppUtils.createMultipart(value.path),
      'ref_photo': "${AppConfig.baseUrl}/uploads/$userPhoto"
    });

    try {
      final _response = await FaceService().recognize(formdata);
      if (_response.data!['_label'] == 'unknown') {
        EasyLoading.showError('Wajah tidak dikenali');
        Get.back();
        return;
      }

      EasyLoading.showSuccess('Berhasil melakukan absen');
      Get.back();
      return;
    } catch (e) {
      catchError(e);
      Get.back();
      return;
    }
  }

  Future<void> handleRecognition(var data) async {
    try {
      var response = await FaceService().recognize(data);
      debugPrint(response.data?.toString());
      if (response.data!['_label'] == 'unknown') {
        throw 'Wajah tidak dikenali';
      }
    } catch (e) {
      return catchError(e);
    }
  }

  void catchError(e) {
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
}
