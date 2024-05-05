import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/response/shifting_response.dart';
import '../../models/shifting.model.dart';
import '../../services/shifting.service.dart';

class ShiftingListController extends GetxController {
  var shiftingResponse = ShfitingResponse().obs;
  var params = <String, dynamic>{}.obs;

  static const _pageSize = 10;

  final PagingController<int, Shifting> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      setShifting(pageKey);
    });
  }

  Future<void> setShifting(int pageKey) async {
    params.addAll({r'$limit': _pageSize, r'$skip': pageKey});

    var response = await ShiftingService().find(params);
    final isLastPage = response.data!.length < _pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(response.data!);
    } else {
      final nextPageKey = pageKey + response.data!.length;
      pagingController.appendPage(response.data!, nextPageKey);
    }
  }
}
