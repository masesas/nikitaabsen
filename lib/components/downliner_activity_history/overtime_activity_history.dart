import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/components/list/basic_list_title_overtime.dart';
import 'package:nikitaabsen/controllers/aprroval.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../controllers/activity.controller.dart';
import '../../models/activity.model.dart';
import '../../models/response/approve_leave.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../not_found/not_found.dart';

class MonitorOvertimeHistory extends StatefulWidget {
  const MonitorOvertimeHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<MonitorOvertimeHistory> createState() => _MonitorOvertimeHistoryState();
}

class _MonitorOvertimeHistoryState extends State<MonitorOvertimeHistory> {
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
    final appLeave = Get.put(ApprovalController2());
    var user = AppUtils.getUser();

    late TextEditingController controllerText;
    final _formKey = GlobalKey<FormBuilderState>();
    final GlobalKey<FormState> _formKes = GlobalKey<FormState>();

    final TextEditingController _textEditingController =
        TextEditingController();

    String keterangan = '';

    final _activity = Get.put(ActivityController({'upliner_id': user.id}));
    _activity.overtimePagingController.addPageRequestListener((pageKey) {
      _activity.setOvertimeActivity(pageKey);
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
                      await appLeave.reject(
                          "OVERTIME", id, _textEditingController.text);
                      Get.back();
                      debugPrint(_textEditingController.text);
                    }
                  },
                  basicText: 'Kirim',
                  loadingText: 'Mengirim',
                  color: mainColor)
            ],
          ),
        );

    return PagedListView<int, Activity>.separated(
      separatorBuilder: (context, index) => const Divider(),
      pagingController: _activity.overtimePagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      builderDelegate: PagedChildBuilderDelegate<Activity>(
        itemBuilder: (context, item, index) {
          return BasicListTileOvertome(
            activity: item,
            onTap: () => showModalBottomSheet(
              //  isScrollControlled: true,
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
                        BasicListTileOvertome(activity: item),
                        // const Divider(
                        //   height: 20,
                        //   thickness: 1,
                        //   indent: 5,
                        //   endIndent: 0,
                        //   color: Colors.black,
                        // ),

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
                                    setState(() {
                                      openDialog(
                                          'OVERTIME', item.id!.toString());
                                    });

                                    // if (keterangan == null ||
                                    //     keterangan.isBlank) return;

                                    // setState(
                                    //     () => this.keterangan = keterangan);
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
                                            activityType: 'OVERTIME',
                                            isApproved: true,
                                          );
                                          print(data.toJson());
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
            "Riwayat lembur tidak ditemukan",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
