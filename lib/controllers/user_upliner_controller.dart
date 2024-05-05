import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/response/user_response.dart';
import '../models/user.model.dart';
import '../models/user_schedule.dart';
import '../services/schedule.service.dart';
import '../services/user-schedule.service.dart';
import '../services/users.service.dart';
import '../utils/app_utils.dart';
import '../utils/constants.dart';

class UserUplinerController extends GetxController {
  var userUpliner = UserResponse();
  var selectedUser = [].obs;
  var loading = false.obs;
  var params = <String, dynamic>{}.obs;
  var queryParams = <String, dynamic>{};
  var options = <S2Choice<String>>[].obs;
  var selected = {}.obs;

  static const _pageSize = 10;

  final PagingController<int, User> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    super.onInit();
    getScheduleList();
    pagingController.addPageRequestListener((pageKey) {
      setDownliner(pageKey);
    });
  }

  void onSelectChanged(S2SingleSelected<String> val, String userId) {
    selected.addAll({userId: val.value});
  }

  List<UserSchedule> userScheduleData() {
    List<UserSchedule> selectedSchedule = [];
    selected.forEach((key, value) {
      selectedSchedule.add(
          UserSchedule(userId: key.toString(), scheduleId: value.toString()));
    });
    return selectedSchedule;
  }

  Future<void> saveUserSchedule() async {
    EasyLoading.show(status: 'Memproses');
    try {
      final userSchedule = userScheduleData();
      // print(userSchedule.toList());
      // EasyLoading.dismiss();
      // return;
      await UserScheduleService().create(userSchedule);
      EasyLoading.showSuccess('Berhasil');
    } catch (err) {
      if (err is DioError) {
        final errorMessage =
            err.response!.data['message'] ?? defaultErrorMessage;
        EasyLoading.showError(errorMessage);
        return;
      }

      EasyLoading.showError(defaultErrorMessage);
      return;
    }
  }

  void setLoading(value) {
    loading.value = value;
  }

  void setParams(Map<String, dynamic> query) {
    params.value = query;
  }

  void onCheckboxChanged(bool? value, String userId) {
    if (value ?? false) {
      selectedUser.add(userId);
      selectedUser.refresh();
    } else {
      selectedUser.remove(userId);
      selectedUser.refresh();
    }
  }

  Future<void> setDownliner(int pageKey) async {
    var user = AppUtils.getUser();

    Map<String, dynamic> params = {
      'upliner_id': user.id,
      r'$limit': _pageSize,
      r'$skip': pageKey,
      'include_user_schedule': '1'
    };

    var response = await UsersService().getKaryawan(params: params);
    userUpliner = response;
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      pagingController.appendPage(response.data!, nextPageKey);
    }
  }

  Future<void> getScheduleList() async {
    setLoading(true);

    final schedule = await ScheduleService().find({});

    options.value = schedule.data!.map((element) {
      return S2Choice<String>(value: element.id!, title: element.name);
    }).toList();

    options.refresh();

    setLoading(false);
  }
}
