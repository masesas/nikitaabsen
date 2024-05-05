import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../form_jam_kerja.dart/jam_kerja_screen.dart';
import '../form_schedule/assign_to.dart';
import '../form_schedule/new_jadwal.dart';
import '../shifting/shifting_list_page.dart';
import '../work_schedule/work_schedule.controller.dart';
import '../work_schedule/work_schedule_list_page.dart';

class ScheduleSettingPage extends StatelessWidget {
  const ScheduleSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.put(WorkScheduleController());

    return DefaultTabController(
      length: _tabBars().length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Atur Jadwal'),
          //actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.add),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                      value: 0, child: Text('Tambah Jadwal')),
                  const PopupMenuItem<int>(
                      value: 1, child: Text('Tambah Jam Kerja')),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('Assign Karyawan'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 0) {
                  final result = await Get.to(const NewJadwal());
                  if (result ?? false) {
                    state.pagingController.refresh();
                  }
                } else if (value == 1) {
                  Get.to(const JamKerja());
                } else if (value == 2) {
                  Get.to(const UserUpliner());
                }
              },
            )
          ],
          bottom: TabBar(
            tabs: _tabBars(),
          ),
        ),
        body: const TabBarView(
          children: [
            WorkScheduleListPage(),
            ShiftingListPage(),
          ],
        ),
      ),
    );
  }

  List<Widget> _tabBars() {
    return [
      const Tab(
        child: Text(
          'Jadwal Kerja',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Jam Kerja',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
    ];
  }
}
