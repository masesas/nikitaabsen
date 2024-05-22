import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:facesdk_plugin/facesdk_plugin.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nikitaabsen/facedetectionview.dart';
import 'package:nikitaabsen/person.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/status_activity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../models/activity.model.dart';
import '../models/response/activity_response.dart';
import '../services/activity.service.dart';

class ActivityController extends GetxController {
  var activity = ActivityResponse().obs;
  var absenActivity = ActivityResponse().obs;
  var overtimeActivity = ActivityResponse().obs;
  var leaveActivity = ActivityResponse().obs;

  var loading = false.obs;
  var params = <String, dynamic>{}.obs;
  var queryParams = <String, dynamic>{};

  static const _pageSize = 10;

  final PagingController<int, Map<String, dynamic>> pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 9999999);

  final PagingController<int, Map<String, dynamic>> absenPagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 9999999);

  final PagingController<int, Map<String, dynamic>> overtimePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Map<String, dynamic>> leavePagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 9999999);

  final PagingController<int, Map<String, dynamic>> sickPagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 9999999);

  ActivityController(this.queryParams);

  @override
  void onInit() {
    super.onInit();
    // pagingController.addPageRequestListener((pageKey) {
    //   setActivity(pageKey);
    // });
  }

  void setLoading(value) {
    loading.value = value;
  }

  void setParams(Map<String, dynamic> query) {
    params.value = query;
  }

  Future<void> setActivity(int pageKey) async {
    setLoading(true);
    /* queryParams.addAll({r'$limit': _pageSize, r'$skip': pageKey});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      pagingController.appendPage(response, nextPageKey);
    } */

    setLoading(false);
  }

  Future<void> setAbsenCheckinActivity(int pageKey) async {
    setLoading(true);
    /*  queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'IN'}); */
    var response = await ActivityService()
        .find(StatusActivity.checkin, params: queryParams);
    final isLastPage = response.length < _pageSize;

    /* if (isLastPage) {
      absenPagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      absenPagingController.appendPage(response, nextPageKey);
    } */

    //absenPagingController.appendLastPage(response);
    absenPagingController.refresh();
    absenPagingController.appendLastPage(response);
    setLoading(false);
  }

  Future<void> setAbsenCheckoutActivity(int pageKey) async {
    setLoading(true);
    /* queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'IN'}); */
    var response = await ActivityService()
        .find(StatusActivity.checkout, params: queryParams);
    final isLastPage = response.length < _pageSize;

    /*  if (isLastPage) {
      pagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      pagingController.appendPage(response, nextPageKey);
    } */
    pagingController.refresh();
    pagingController.appendLastPage(response);

    setLoading(false);
  }

  Future<void> setLeaveActivity(int pageKey) async {
    setLoading(true);
    /*   queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'CUTI'}); */
    var response =
        await ActivityService().find(StatusActivity.cuti, params: queryParams);
    final isLastPage = response.length < _pageSize;

    /* if (isLastPage) {
      leavePagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      leavePagingController.appendPage(response, nextPageKey);
    } */
    leavePagingController.refresh();
    leavePagingController.appendLastPage(response);

    setLoading(false);
  }

  Future<void> setOvertimeActivity(int pageKey) async {
    setLoading(true);
    /* queryParams.addAll(
        {r'$limit': _pageSize, r'$skip': pageKey, 'status': 'OVERTIME'});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      overtimePagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      overtimePagingController.appendPage(response, nextPageKey);
    } */

    setLoading(false);
  }

  Future<void> setSickActivity(int pageKey) async {
    setLoading(true);
    /*  queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'SAKIT'}); */
    var response =
        await ActivityService().find(StatusActivity.izin, params: queryParams);
    final isLastPage = response.length < _pageSize;

    /* if (isLastPage) {
      sickPagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      sickPagingController.appendPage(response, nextPageKey);
    } */
    sickPagingController.refresh();
    sickPagingController.appendLastPage(response);

    setLoading(false);
  }

  ActivityResponse getActivity() {
    return activity.value;
  }

  Future<void> getAbsen() async {
    final params = {"limit": "999999999999"};
    final checkout =
        await ActivityService().find(StatusActivity.checkout, params: params);
    final checkin =
        await ActivityService().find(StatusActivity.checkin, params: params);

    final user = AppUtils.getUser();
    final facesdkPlugin = FacesdkPlugin();
    final db = await createDB();
    final tempDir = await path_provider.getTemporaryDirectory();

    List<Map<String, dynamic>> absenList = [
      ...checkin,
      ...checkout,
    ];

    for (var i = 0; i < absenList.length; i++) {
      if ((absenList[i]['att_selfie'] as String).isNotEmpty) {
        final url = AppUtils.getUrl(
            "/res/file?inline=true&file=${absenList[i]['att_selfie']}");
        final bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
            .buffer
            .asUint8List();

        File file = await File(
                '${tempDir.path}/absen-${DateTime.now().microsecondsSinceEpoch}.png')
            .create();
        file.writeAsBytesSync(bytes);

        final rotatedImage =
            await FlutterExifRotation.rotateImage(path: file.path);
        final faces = await facesdkPlugin.extractFaces(rotatedImage.path);

        if (faces != null && (faces as List).isNotEmpty) {
          for (var face in faces) {
            final randomNumber =
                10000 + Random().nextInt(10000); // from 0 upto 99 included
            final person = Person(
              name: '${user.fullname!}-$randomNumber',
              faceJpg: face['faceJpg'],
              templates: face['templates'],
            );

            await db.insert(
              'person',
              person.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
      }
    }
  }
}
