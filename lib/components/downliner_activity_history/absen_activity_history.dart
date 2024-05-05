import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/activity.controller.dart';
import '../../controllers/approval.controller.dart';
import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../button/basic_button.dart';
import '../list/basic_list_tile.dart';
import '../maps/maps_screen.dart';
import '../not_found/not_found.dart';

class MonitorAbsenHistory extends StatefulWidget {
  const MonitorAbsenHistory({Key? key}) : super(key: key);

  @override
  State<MonitorAbsenHistory> createState() => _MonitorAbsenHistoryState();
}

class _MonitorAbsenHistoryState extends State<MonitorAbsenHistory> {
  late TextEditingController controller;
  var loading = true.obs;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _approveController = Get.put(ApprovalController());

    var user = AppUtils.getUser();

    final TextEditingController _textEditingController =
        TextEditingController();

    final _activity = Get.put(ActivityController({'upliner_id': user.id}));
    _activity.absenPagingController.addPageRequestListener((pageKey) {
      _activity.setAbsenActivity(pageKey);
    });

    Future openDialog(String type, String id) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text('Keterangan Reject'),
                ),
              ],
            ),
            content: TextField(
              autofocus: true,
              controller: _textEditingController,
            ),
            actions: [
              BasicButton(
                  onPressed: () async {
                    if (_textEditingController.text == null ||
                        _textEditingController.text.isEmpty) {
                      EasyLoading.showError('Harap masukan keterangan reject!');
                    } else {
                      Get.back();

                      debugPrint(_textEditingController.text);
                      var response = await _approveController.rejectAbsens(
                          type, id, _textEditingController.text);
                    }
                  },
                  basicText: 'Simpan',
                  color: mainColor)
            ],
          ),
        );

    return PagedListView<int, Activity>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: _activity.absenPagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Activity>(
        itemBuilder: (context, item, index) {
          return BasicListTile(
            activity: item,
            onTap: () => item.isApproved == null
                ? showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Wrap(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: SizedBox(
                              height: 200,
                              child: MapScreen(
                                lat: double.parse(item.latitude!),
                                lng: double.parse(item.longitude!),
                              ),
                            ),
                          ),
                          BasicListTile(activity: item),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 5,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Yakin approve ini ?',
                            style: TextStyle(fontSize: 19),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: BasicButton(
                                    onPressed: () async {
                                      openDialog('IN', item.id!.toString());

                                      debugPrint(jsonEncode(item));
                                    },
                                    color: Colors.red,
                                    basicText: 'Tolak',
                                    loadingText: 'Proses',
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: BasicButton(
                                    onPressed: () async {
                                      var datass = await _approveController
                                          .approvalAbsens(
                                              'IN', item.id!.toString());
                                    },
                                    color: mainColor,
                                    basicText: 'Setujui',
                                    loadingText: 'Proses',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : EasyLoading.showError('Sudah di Action'),
          );
        },
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
