import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../components/not_found/not_found.dart';
import '../../models/schedule.dart';
import '../edit_schedule/edit_schedule_page.dart';
import 'work_schedule.controller.dart';

class WorkScheduleListPage extends StatelessWidget {
  const WorkScheduleListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.put(WorkScheduleController());

    return PagedListView<int, Schedule>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: state.pagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Schedule>(
        itemBuilder: (context, item, index) => ListTile(
          title: Text(item.name!),
          trailing: IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () async {
              bool? result = await Get.to(
                EditSchedulePage(
                  schedule: item,
                ),
                arguments: item,
              );

              if (result ?? false) {
                print('trigger');
                state.pagingController.refresh();
              }
            },
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => NotFound(
          image: Image.asset('assets/images/attendance.png',
              height: MediaQuery.of(context).size.height * 0.4),
          title: const Text(
            "Tidak Ada Riwayat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Text(
            "Riwayat absen tidak ditemukan",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
