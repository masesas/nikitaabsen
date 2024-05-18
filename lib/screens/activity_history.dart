import 'package:flutter/material.dart';

import '../components/activity_history/absen_activity_history.dart';
import '../components/activity_history/all_activity_history.dart';
import '../components/activity_history/leave_activity_history.dart';
import '../components/activity_history/overtime_activity_history.dart';
import '../components/activity_history/sick_activity_history.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabBars().length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat'),
          bottom: TabBar(
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 35),
            tabs: _tabBars(),
          ),
        ),
        body: const TabBarView(
          children: [
            ActivityHistoryPagedView(),
            AbsenActivityHistory(),
            //OvertimeActivityHistory(),
            LeaveActivityHistory(),
            SickActivityHistory(),
          ],
        ),
      ),
    );
  }

  List<Widget> _tabBars() {
    return [
      const Tab(
        child: Text(
          'Checkin',
          style: TextStyle(fontFamily: 'Checkin'),
        ),
      ),
      const Tab(
        child: Text(
          'Checkout',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      /* const Tab(
        child: Text(
          'Lembur',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ), */
      const Tab(
        child: Text(
          'Cuti',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
      const Tab(
        child: Text(
          'Izin',
          style: TextStyle(fontFamily: 'WorkSans'),
        ),
      ),
    ];
  }
}
