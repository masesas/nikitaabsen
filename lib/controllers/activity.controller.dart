import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  final PagingController<int, Activity> pagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Activity> absenPagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Activity> overtimePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Activity> leavePagingController =
      PagingController(firstPageKey: 0);

  final PagingController<int, Activity> sickPagingController =
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
    queryParams.addAll({r'$limit': _pageSize, r'$skip': pageKey});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      pagingController.appendPage(response.data!, nextPageKey);
    }

    setLoading(false);
  }

  Future<void> setAbsenActivity(int pageKey) async {
    setLoading(true);
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'IN'});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      absenPagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      absenPagingController.appendPage(response.data!, nextPageKey);
    }

    setLoading(false);
  }

  Future<void> setLeaveActivity(int pageKey) async {
    setLoading(true);
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'CUTI'});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      leavePagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      leavePagingController.appendPage(response.data!, nextPageKey);
    }

    setLoading(false);
  }

  Future<void> setOvertimeActivity(int pageKey) async {
    setLoading(true);
    queryParams.addAll(
        {r'$limit': _pageSize, r'$skip': pageKey, 'status': 'OVERTIME'});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      overtimePagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      overtimePagingController.appendPage(response.data!, nextPageKey);
    }

    setLoading(false);
  }

  Future<void> setSickActivity(int pageKey) async {
    setLoading(true);
    queryParams
        .addAll({r'$limit': _pageSize, r'$skip': pageKey, 'status': 'SAKIT'});
    var response = await ActivityService().find(params: queryParams);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      sickPagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      sickPagingController.appendPage(response.data!, nextPageKey);
    }

    setLoading(false);
  }

  ActivityResponse getActivity() {
    return activity.value;
  }
}
