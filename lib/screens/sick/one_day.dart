import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:intl/intl.dart';

class OneDay extends StatelessWidget {
  const OneDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userC = Get.put(UserController());
    // final inAct = Get.put(ActController());
    DateTime dateTame = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy, HH:mm').format(dateTame);
    final _requestActivity = Get.put(RequestActivityController());
    final _formKey = GlobalKey<FormBuilderState>();
    var user = AppUtils.getUser();

    TextEditingController textarea = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Waktu izin : ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BasicButton(
                    basicText: 'Simpan',
                    onPressed: () async {
                      var usera = AppUtils.getUser();

                      var datssa = await _requestActivity.izinSakit1Day(
                          'SAKIT',
                          usera.id.toString(),
                          dateTame.toIso8601String(),
                          dateTame.toIso8601String());
                    },
                    isLoading: false,
                    loadingText: 'Memproses',
                    color: mainColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
