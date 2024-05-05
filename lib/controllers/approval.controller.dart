import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:nikitaabsen/models/request/approve_absen_request.dart';
import 'package:nikitaabsen/models/request/reject_absen_request.dart';
import 'package:nikitaabsen/services/approval.service.dart';

class ApprovalController extends GetxController {
  var error = false.obs;
  var done = false.obs;
  var message = ''.obs;
  var loading = false.obs;

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

  Future<void> approvalAbsens(
    String activity_type,
    String activity_id,
  ) async {
    setLoading(true);
    EasyLoading.show();
    var dataApproval = ApproveAbsenRequest(
      activityId: activity_id,
      activityType: activity_type,
      isApproved: true,
    );

    try {
      var response = await ApprovalService().approveAbsen(dataApproval);
      EasyLoading.showSuccess('Data user berhasil di approve!');
      setLoading(false);
      EasyLoading.dismiss();
      Get.back();
    } catch (e) {
      setLoading(false);
      EasyLoading.dismiss();

      if (e is dio.DioError) {
        var codeResponse = jsonEncode(e.response?.data?['code']);

        var message =
            e.response?.data?['message'] ?? 'Terjadi kesalahan pada server';

        if (codeResponse == '409') {
          EasyLoading.showError(message);
        }

        return;
      }
      EasyLoading.showError('Terjadi kesalahan pada server');
      return;
    }
  }

  Future<void> rejectAbsens(
    String activity_type,
    String activity_id,
    String rejectReasonIn,
  ) async {
    setLoading(true);
    EasyLoading.show();
    var dataApproval = RejectAbsenApproval(
      activityId: activity_id,
      activityType: activity_type,
      rejectReasonIn: rejectReasonIn,
      isApproved: false,
    );

    try {
      var response = await ApprovalService().rejectAbsen(dataApproval);
      EasyLoading.showSuccess('Data user berhasil di reject!');
      setLoading(false);
      EasyLoading.dismiss();
      Get.back();
    } catch (e) {
      setLoading(false);
      EasyLoading.dismiss();

      if (e is dio.DioError) {
        var codeResponse = jsonEncode(e.response?.data?['code']);

        var message =
            e.response?.data?['message'] ?? 'Terjadi kesalahan pada server';

        if (codeResponse == '409') {
          EasyLoading.showError(message);
        }

        return;
      }
      EasyLoading.showError('Terjadi kesalahan pada server');
      return;
    }
  }
}
