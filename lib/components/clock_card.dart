import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/controllers/home.controller.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/models/user.model.dart';
import 'package:intl/intl.dart';

import '../utils/app_utils.dart';
import '../utils/buttons/button_style.dart';

class ClockCard extends StatelessWidget {
  const ClockCard({
    Key? key,
    required this.user,
    required this.onPressedClockIn,
    required this.onPressedClockOut,
    required this.profile,
  }) : super(key: key);

  final User user;
  final VoidCallback? onPressedClockIn;
  final VoidCallback? onPressedClockOut;
  final Map<String, dynamic> profile;

  @override
  Widget build(BuildContext context) {
    var shiftFrom = user.shifting?.from ?? '09:00:00';
    var shiftTo = user.shifting?.to ?? '18:00:00';
    var shiftName = user.shifting?.name ?? 'Shift Pagi';

    var formatShitFrom = AppUtils.formatTime(shiftFrom);
    var formatShiftTo = AppUtils.formatTime(shiftTo);

    final String today =
        DateFormat('EEE, dd MMM yyyy', 'id').format(DateTime.now());
    final profileCheckin = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse((profile['checkin'] as String?) ?? DateTime.now().toString());

    final hasCheckinToday = DateTime.now().isDateEqual(profileCheckin);

    return Obx(() {
      final homeController = Get.find<HomeController>();

      String nextAttendace =
          homeController.nextStatusAttendace.value;
      if (nextAttendace.isEmpty) {
        nextAttendace = "CHECKIN";
      }

      String lastCheckin = homeController.lastWaktuCheckin.value;
      if (lastCheckin.isEmpty) {
        lastCheckin = '-----';
      }
      String lastCheckout = homeController.lastWaktuCheckout.value;
      if (lastCheckout.isEmpty) {
        lastCheckout = '------';
      }

      final btnText = nextAttendace;
      final btnStyle = nextAttendace == 'CHECKIN'
          ? clockButton(time: '2022-01-01')
          : clockButton();

      return SizedBox(
        //height: 240.0,
        child: Container(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 15.0,
            right: 15.0,
            bottom: 10.0,
          ),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  /* if (profile["last_attendance"] != "CHECKIN" ||
                        profile["last_attendance"] != "CHECKOUT")
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Anda Sedang Izin ${profile['last_attendance']}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ), */
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hari'),
                        Text(
                          today,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Waktu Checkin Terakhir\n$lastCheckin",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Waktu Checkout Terakhir\n$lastCheckout",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onPressedClockIn,
                            style: btnStyle,
                            child: Text(btnText),
                          ),
                        ),
                        /* const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onPressedClockOut,
                              child: const Text('Keluar'),
                              style: clockButton(),
                            ),
                          ), */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
