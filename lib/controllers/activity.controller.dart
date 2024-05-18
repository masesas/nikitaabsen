import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nikitaabsen/utils/status_activity.dart';

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
      PagingController(firstPageKey: 0);

  final PagingController<int, Map<String, dynamic>> absenPagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Map<String, dynamic>> overtimePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Map<String, dynamic>> leavePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Map<String, dynamic>> sickPagingController =
      PagingController(firstPageKey: 0);

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
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'IN'});
    var response = await ActivityService().find(StatusActivity.checkin, params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      absenPagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      absenPagingController.appendPage(response, nextPageKey);
    }

    setLoading(false);
  }

    Future<void> setAbsenCheckoutActivity(int pageKey) async {
    setLoading(true);
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'IN'});
    var response = await ActivityService()
        .find(StatusActivity.checkout, params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      pagingController.appendPage(response, nextPageKey);
    }

    setLoading(false);
  }

  Future<void> setLeaveActivity(int pageKey) async {
    setLoading(true);
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'CUTI'});
    var response = await ActivityService().find(StatusActivity.cuti, params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      leavePagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      leavePagingController.appendPage(response, nextPageKey);
    }

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
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'SAKIT'});
    var response = await ActivityService().find(StatusActivity.izin, params: queryParams);
    final isLastPage = response.length < _pageSize;

    if (isLastPage) {
      sickPagingController.appendLastPage(response);
    } else {
      final nextPageKey = pageKey + response.length;
      sickPagingController.appendPage(response, nextPageKey);
    }

    setLoading(false);
  }

  ActivityResponse getActivity() {
    return activity.value;
  }
}
