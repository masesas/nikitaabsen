import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/list/basic_list_tile.dart';
import 'package:nikitaabsen/components/list/basic_list_title_overtime.dart';
import 'package:nikitaabsen/components/not_found/not_found.dart';
import 'package:nikitaabsen/controllers/activity.controller.dart';
import 'package:nikitaabsen/models/activity.model.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OvertimeActivityHistory extends StatelessWidget {
  const OvertimeActivityHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = AppUtils.getUser();
    final _activity = Get.put(ActivityController({'user_id': user.id}));
    _activity.overtimePagingController.addPageRequestListener((pageKey) {
      _activity.setOvertimeActivity(pageKey);
    });

    return PagedListView<int, Map<String, dynamic>>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: _activity.overtimePagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
        itemBuilder: (context, item, index) {
          //return BasicListTileOvertome(activity: item);
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
            "Riwayat lembur tidak ditemukan",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
