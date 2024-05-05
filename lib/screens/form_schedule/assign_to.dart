import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../components/button/basic_button.dart';
import '../../components/not_found/not_found.dart';
import '../../controllers/user_upliner_controller.dart';
import '../../models/user.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import 'widgets/assign_select_list.dart';

class UserUpliner extends StatefulWidget {
  const UserUpliner({
    Key? key,
  }) : super(key: key);

  @override
  State<UserUpliner> createState() => _UserUplinerState();
}

class _UserUplinerState extends State<UserUpliner> {
  @override
  Widget build(BuildContext context) {
    final state = Get.put(UserUplinerController());

    return Obx(
      () => state.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Pilih karyawan'),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BasicButton(
                  basicText: 'Terapkan',
                  color: mainColor,
                  onPressed: state.saveUserSchedule,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: PagedListView<int, User>.separated(
                separatorBuilder: (context, index) => const Divider(),
                pagingController: state.pagingController,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, item, index) => AssignSelectList(
                    user: item,
                    scheduleOptions: state.options,
                    onChange: (val) => state.onSelectChanged(val, item.id!),
                    selectedValue:
                        AppUtils.getUserSchedule(state.selected[item.id], item),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => NotFound(
                    image: Image.asset('assets/images/attendance.png',
                        height: MediaQuery.of(context).size.height * 0.4),
                    title: const Text(
                      "Anda belum memiliki bawahan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    content: const Text(
                      "Bawahan anda tidak di temukan",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
