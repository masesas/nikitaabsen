import 'package:flutter/material.dart';

import '../components/downliner_activity_history/absen_activity_history.dart';
import '../components/downliner_activity_history/all_activity_history.dart';
import '../components/downliner_activity_history/leave_activity_history.dart';
import '../components/downliner_activity_history/overtime_activity_history.dart';
import '../components/downliner_activity_history/sick_activity_history.dart';

class DownlinerActivityHistory extends StatelessWidget {
  const DownlinerActivityHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabBars().length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Monitor'),
          bottom: TabBar(
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 35),
            tabs: _tabBars(),
          ),
        ),
        body: const TabBarView(
          children: [
            MonitorAllHistory(),
            MonitorAbsenHistory(),
            MonitorOvertimeHistory(),
            MonitorLeaveHistory(),
            MonitorSickHistory(),
          ],
        ),
      ),
    );
  }

  List<Widget> _tabBars() {
    return [
      const Tab(
        child: Text(
          'Semua',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Hadir',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Lembur',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Cuti',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Sakit',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
    ];
  }
}
