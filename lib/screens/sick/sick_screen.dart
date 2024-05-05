import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nikitaabsen/faces/nikitaface.dart';
import 'package:nikitaabsen/screens/sick/one_day.dart';
import 'package:nikitaabsen/screens/sick/over_day.dart';

class SickScreen extends StatefulWidget {
  const SickScreen({Key? key}) : super(key: key);

  @override
  State<SickScreen> createState() => _SickScreenState();
}

class _SickScreenState extends State<SickScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Form Izin Sakit'),
    ),
        body: NikitaFace());
  }
  Widget builda(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Izin Sakit'),
      ),
      body: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.black,
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              text: '1 Hari',
                            ),
                            Tab(
                              text: '>1 hari',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [OneDay(), OverOneDay()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
