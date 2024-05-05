import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/models/response/approve_leave.dart';
import 'package:nikitaabsen/services/aprooval_service.dart';
import 'package:dio/dio.dart' as dio;

import '../models/request/reject_request.dart';

class ApprovalController2 extends GetxController {
  var loading = false.obs;

  setLoading(value) {
    loading.value = value;
  }

  Future<void> handleOvertime(
      approvalLeaveResponse approvalLeaveResponse) async {
    setLoading(true);
    EasyLoading.show(status: 'Mengirim data');
    try {
      await ApprovalService().leave(approvalLeaveResponse);
      EasyLoading.showSuccess('Berhasil');
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

  Future<void> approval(
    String activity_type,
    String activity_id,
  ) async {
    setLoading(true);

    var dataApproval = approvalLeaveResponse(
      activityId: activity_id,
      activityType: activity_type,
      isApproved: true,
    );

    try {
      var response = await ApprovalService().leave(dataApproval);
      EasyLoading.showSuccess('berhasil di approve!');
      setLoading(false);
      Get.back();
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

  Future<void> reject(
    String activity_type,
    String activity_id,
    String rejectReasonIn,
  ) async {
    setLoading(true);
    EasyLoading.show(status: 'Mengirim data');
    var dataApproval = RejectApproval(
      activityId: activity_id,
      activityType: activity_type,
      rejectReasonIn: rejectReasonIn,
      isApproved: false,
    );

    try {
      var response = await ApprovalService().reject(dataApproval);
      EasyLoading.showSuccess('berhasil di reject!');
      setLoading(false);
      Get.back();
    } catch (e) {
      setLoading(false);

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
