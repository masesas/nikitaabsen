import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/response/schedule_response.dart';
import '../../models/schedule.dart';
import '../../services/schedule.service.dart';

class ScheduleListController extends GetxController {
  var scheudules = ScheduleResponse().obs;
  var params = <String, dynamic>{}.obs;

  static const _pageSize = 10;

  final PagingController<int, Schedule> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      setSchedule(pageKey);
    });
  }

  Future<void> setSchedule(int pageKey) async {
    params.addAll({r'$limit': _pageSize, r'$skip': pageKey});

    var response = await ScheduleService().find(params);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      pagingController.appendPage(response.data!, nextPageKey);
    }
  }
}
