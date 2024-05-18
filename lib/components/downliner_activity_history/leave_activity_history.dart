/* import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/components/list/basic_list_title_leave.dart';
import 'package:nikitaabsen/controllers/aprroval.dart';
import 'package:nikitaabsen/models/response/approve_leave.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/activity.controller.dart';
import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../list/basic_list_tile.dart';
import '../not_found/not_found.dart';

class MonitorLeaveHistory extends StatefulWidget {
  const MonitorLeaveHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<MonitorLeaveHistory> createState() => _MonitorLeaveHistoryState();
}

class _MonitorLeaveHistoryState extends State<MonitorLeaveHistory> {
  final appLeave = Get.put(ApprovalController2());
  late TextEditingController controller;

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
    var user = AppUtils.getUser();
    final _activity = Get.put(ActivityController({'upliner_id': user.id}));
    _activity.leavePagingController.addPageRequestListener((pageKey) {
      _activity.setLeaveActivity(pageKey);
    });

    final TextEditingController _textEditingController =
        TextEditingController();

    String keterangan = '';

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
                      var datass = await appLeave.reject(
                          'CUTI', id, _textEditingController.text);
                      Get.back();
                      debugPrint(_textEditingController.text);
                    }
                  },
                  basicText: 'Kirim',
                  color: mainColor)
            ],
          ),
        );

    return PagedListView<int, Activity>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: _activity.leavePagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Activity>(
        itemBuilder: (context, item, index) {
          return BasicListTileLeave(
            activity: item,
            onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (context) => Container(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BasicListTileLeave(activity: item),
                        // const Divider(
                        //   height: 20,
                        //   thickness: 1,
                        //   indent: 5,
                        //   endIndent: 0,
                        //   color: Colors.black,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: BasicButton(
                                  onPressed: () {
                                    setState(() {
                                      openDialog('CUTI', item.id!.toString());
                                    });

                                    // if (keterangan == null ||
                                    //     keterangan.isBlank) return;

                                    // setState(() => this.keterangan = keterangan);
                                  },
                                  color: Colors.red,
                                  basicText: 'Tolak',
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: BasicButton(
                                  onPressed: appLeave.loading.value
                                      ? null
                                      : () async {
                                          var data = approvalLeaveResponse(
                                            activityId: (item.id!.toString()),
                                            activityType: 'CUTI',
                                            isApproved: true,
                                          );
                                          await appLeave.handleOvertime(data);
                                        },
                                  color: mainColor,
                                  basicText: 'Setujui',
                                  isLoading: appLeave.loading.value,
                                  loadingText: 'Mengirim',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
            "Riwayat cuti tidak ditemukan",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
 */