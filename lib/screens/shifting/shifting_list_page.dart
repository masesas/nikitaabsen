import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../components/not_found/not_found.dart';
import '../../models/shifting.model.dart';
import '../form_jam_kerja.dart/edit_jam_kerja.dart';
import 'shifting_list.controller.dart';
import 'widgets/shifting_list_tile.dart';

class ShiftingListPage extends StatelessWidget {
  const ShiftingListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.put(ShiftingListController());

    return PagedListView<int, Shifting>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: state.pagingController,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      builderDelegate: PagedChildBuilderDelegate<Shifting>(
        itemBuilder: (context, item, index) => ShiftingListTile(
          shifting: item,
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditJamKerja(
                  shiftResponse: item,
                ),
              ),
            );

            if (result != null) {
              state.pagingController.refresh();
            }
          },
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
