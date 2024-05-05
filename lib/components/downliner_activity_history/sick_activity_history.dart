import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/activity.controller.dart';
import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../list/basic_list_tile.dart';
import '../not_found/not_found.dart';

class MonitorSickHistory extends StatelessWidget {
  const MonitorSickHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = AppUtils.getUser();
    final _activity = Get.put(ActivityController({'upliner_id': user.id}));
    _activity.sickPagingController.addPageRequestListener((pageKey) {
      _activity.setSickActivity(pageKey);
    });

    return PagedListView<int, Activity>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: _activity.sickPagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Activity>(
        itemBuilder: (context, item, index) {
          return BasicListTile(activity: item);
        },
        noItemsFoundIndicatorBuilder: (context) => NotFound(
          image: Image.asset('assets/images/attendance.png',
              height: MediaQuery.of(context).size.height * 0.4),
          title: const Text(
            "Tidak Ada Riwayat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Text(
            "Riwayat sakit tidak ditemukan",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
