import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nikitaabsen/controllers/home.controller.dart';
import 'package:nikitaabsen/models/shifting.model.dart';
import 'package:nikitaabsen/screens/shifting/shifting_list_page.dart';
import 'package:nikitaabsen/utils/status_activity.dart';
import '../components/form/locpoint_form.dart';
import '../models/request/document_sakit.dart';
import '../models/request/izin_sakit.dart';
import '../models/request/overtime_request.dart';
import '../models/request/register_mobile.dart';
import '../models/request/shift_request.dart';
import '../models/response/shifting_response.dart';
import '../screens/home.dart';
import '../services/location_point_service.dart';
import '../services/shifting.service.dart';

import '../models/clock_in.model.dart';
import '../models/clock_out.dart';
import '../models/request/izin_request.model.dart';
import '../services/request_activity.service.dart';
import '../services/upload.service.dart';
import '../utils/app_utils.dart';
import '../utils/geolocator/get_location.dart';

class RequestActivityController extends GetxController {
  var shifting = ShfitingResponse().obs;
  var loading = false.obs;
  var info = false.obs;
  var message = ''.obs;
  var user = AppUtils.getUser();

  var homeController = Get.find<HomeController>();

  // var locpointss = AppUtils.getLocPoint();

  @override
  void onInit() {
    super.onInit();
    //setShifting();
  }

  setLoading(value) {
    loading.value = value;
  }

  Future<void> setShifting() async {
    setLoading(true);
    var response = await ShiftingService().find({});
    shifting.update((val) {
      val!.data = response.data;
      val.total = response.total;
      val.limit = response.limit;
      val.skip = response.skip;
    });
    setLoading(false);
  }

  setInfoMessage(bool value, String infoMsg) {
    info.value = value;
    message.value = infoMsg;
  }

  Future<void> handleIn(
      String filepath, String userId, String? notes, bool? is_wfh) async {
    setLoading(true);

    try {
      final currentPosition = await Geolocator.getCurrentPosition();
      var response = await LocationPoinService().findRadius();
      var userlat = user.locationPoint!.latitude!;
      var userlong = user.locationPoint!.longitude!;
      var radiusmax = response.maxRadius;

      var distanceInMeter = Geolocator.distanceBetween(
          currentPosition.longitude,
          currentPosition.latitude,
          double.parse(userlat),
          double.parse(userlong));

      var distance = distanceInMeter.round().toInt();

      setInfoMessage(true, distance.toString());

      if (distance > radiusmax!) {
        if (notes == null) {
          EasyLoading.showError('Harap isi keterangan, Absen diluar radius');
          setLoading(false);
          return;
        }
      }
      String filename = filepath.split('/').last;
      final uploadFormData = dio.FormData.fromMap({
        'uri': await AppUtils.createMultipart(filepath),
      });
      final uploadId = await UploadService().create(uploadFormData);
      final clockInData = ClockIn(
          checkInPhoto: uploadId,
          userId: userId,
          latitude: currentPosition.latitude.toString(),
          longitude: currentPosition.longitude.toString(),
          requestType: 'IN',
          notes: notes,
          is_wfh: is_wfh);

      await RequestActivityService().clockIn(clockInData);
      EasyLoading.showSuccess('Berhasil melakukan absen');
      setLoading(false);
      Get.off(const HomeScreen());

      return;
    } catch (e) {
      setLoading(false);
      if (e is dio.DioError) {
        var message =
            e.response?.data?['message'] ?? 'Terjadi kesalahan pada server';
        EasyLoading.showError(message);
        Get.off(const HomeScreen());
        return;
      }
      EasyLoading.showError('Terjadi kesalahan pada server');
      return;
    }
  }

  Future<void> izinSakit(
      String request_type,
      String userId,
      String sick_request_date_from,
      String sick_request_date_to,
      XFile file) async {
    setLoading(true);
    final currentPosition = await determinePosition();
    String filename = file.path.split('/').last;

    final uploadFormData = dio.FormData.fromMap({
      'uri': await AppUtils.createMultipart(file.path),
    });
    final uploadId = await UploadService().create(uploadFormData);
    //  print(upload);

    var uploadDocument = [UserSickDocument(document: uploadId)];
    //   print(json.encode(uploadDocument));

    final izinSakit = DocumentSick(
        requestType: request_type,
        sickRequestDateFrom: sick_request_date_from,
        sickRequestDateTo: sick_request_date_to,
        userId: userId,
        userSickDocument: uploadDocument);

    // print(json.encode(uploadDocument));

    try {
      await RequestActivityService().izinSakit(izinSakit);
      EasyLoading.showSuccess('Pengajuan berhasil di kirim');
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

  Future<void> izinSakit1Day(
    String request_type,
    String userId,
    String sick_request_date_from,
    String sick_request_date_to,
  ) async {
    setLoading(true);
//   print(json.encode(uploadDocument));

    final izinSakit = DocumentSick(
      requestType: request_type,
      sickRequestDateFrom: sick_request_date_from,
      sickRequestDateTo: sick_request_date_to,
      userId: userId,
    );

    // print(json.encode(uploadDocument));

    try {
      await RequestActivityService().izinSakit(izinSakit);
      EasyLoading.showSuccess('Pengajuan berhasil di kirim');
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

  Future<void> handleOut() async {
    setLoading(true);
    try {
      var user = AppUtils.getUser();
      var data = ClockOut(requestType: 'OUT', userId: user.id);
      await RequestActivityService().clockOut(data);
      EasyLoading.showSuccess("Berhasil absen pulang");
      Get.back();
      setLoading(false);
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

  Future<void> handleIzin(IzinRequest izinRequest) async {
    setLoading(true);
    try {
      await RequestActivityService().izin(izinRequest);
      EasyLoading.showSuccess('Berhasil mengajukan cuti');
      Get.back();
      setLoading(false);
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

  void catchClockInError(e) {
    if (e is dio.DioError) {
      if (e.type == dio.DioErrorType.connectTimeout) {
        EasyLoading.showError(
            'Koneksi timeout, silahkan cek koneksi internet anda');
        return;
      }
      if (e.response?.data != null) {
        var message = e.response!.data['message'];
        EasyLoading.showError(message);
        return;
      }
      EasyLoading.showError('Maaf terjadi kesalahan pada server');
      return;
    }
    EasyLoading.showError('Maaf terjadi kesalahan pada server');
    return;
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

  Future<void> handleOvertime(overtimeRequest overtimeRequest) async {
    setLoading(true);
    try {
      await RequestActivityService().overtime(overtimeRequest);
      EasyLoading.showSuccess('Berhasil mengajukan Overtime');
      Get.back();
      setLoading(false);
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

  Future<void> handleShifting(ShiftingRequest shiftingRequest) async {
    setLoading(true);
    try {
      await ShiftingService().addshift(shiftingRequest);
      EasyLoading.showSuccess('Berhasil menambahkan jam kerja');
      Get.back();
      setLoading(false);
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

  Future editJk(var data, BuildContext ctx, String id) async {
    try {
      await ShiftingService().editJk(data, id);
      Navigator.pop(ctx, true);
      EasyLoading.showSuccess("Berhasil");
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

  Future deleteJk(String id, BuildContext ctx) async {
    try {
      await ShiftingService().deleteJk(id);
      Navigator.pushReplacement(ctx,
          MaterialPageRoute(builder: (BuildContext ctx) => ShiftingListPage()));
      EasyLoading.showSuccess('Berhasil');
      return;
    } catch (e) {
      setLoading(false);
      if (e is dio.DioError) {
        var message =
            e.response?.data?['meddage'] ?? 'Terjadi kesalahan pada server';
        EasyLoading.showError(message);
        return;
      }
      EasyLoading.showError('Terjadi kesalahan pada server');
      return;
    }
  }

  Future<void> saveActivity(
      StatusActivity activity, Map<String, dynamic> data) async {
    EasyLoading.show();
    setLoading(true);

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      
      data['location'] = await Geolocator.getCurrentPosition();
      data['mocked'] = position.isMocked;
      data['acuration'] = position.accuracy;

      if ((data['selfie'] as String?) != null &&
          (data['selfie'] as String?)!.isNotEmpty) {
        final uploadFormData = dio.FormData.fromMap({
          'image': await AppUtils.createMultipart(data['selfie']),
        });

        final uploadId = await UploadService().create(uploadFormData);
        data['selfie'] = uploadId;
      }

      await RequestActivityService().saveAktivity(activity, data);
      EasyLoading.showSuccess("Berhasil menyimpan aktivitas")
          .then((value) => Get.back());

      final box = GetStorage();
      await box.write(
          'nextStatusAttendance',
          activity == StatusActivity.checkin
              ? 'CHECKOUT'
              : activity == StatusActivity.checkout
                  ? 'CHECKIN'
                  : activity.name.toUpperCase());

      if (activity == StatusActivity.checkin) {
        await box.write('lastWaktuCheckin',
            DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()));
      } else if (activity == StatusActivity.checkout) {
        await box.write('lastWaktuCheckout',
            DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now()));
      }

      homeController.getCurrentUser();
      homeController.getSessionAttendace();
    } catch (e) {
      EasyLoading.showError('Terjadi kesalahan pada server');
    }

    EasyLoading.dismiss();
    setLoading(false);
  }
}
