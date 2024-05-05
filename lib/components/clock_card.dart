import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final User user;
  final VoidCallback? onPressedClockIn;
  final VoidCallback? onPressedClockOut;

  @override
  Widget build(BuildContext context) {
    var shiftFrom = user.shifting?.from ?? '09:00:00';
    var shiftTo = user.shifting?.to ?? '18:00:00';
    var shiftName = user.shifting?.name ?? 'Shift Pagi';

    var formatShitFrom = AppUtils.formatTime(shiftFrom);
    var formatShiftTo = AppUtils.formatTime(shiftTo);

    final String today =
        DateFormat('EEE, dd MMM yyyy', 'id').format(DateTime.now());

    return SizedBox(
      height: 240.0,
      child: Container(
        padding: const EdgeInsets.only(
            top: 40.0, left: 15.0, right: 15.0, bottom: 10.0),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.white,
          child: Column(
            children: <Widget>[
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
              Text(
                "$formatShitFrom - $formatShiftTo",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                shiftName,
                style: const TextStyle(color: Colors.grey),
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
                        child: const Text('Masuk'),
                        style: clockButton(time: '2022-01-01'),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPressedClockOut,
                        child: const Text('Keluar'),
                        style: clockButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
