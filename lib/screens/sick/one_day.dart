import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/services/request_activity.service.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:nikitaabsen/utils/status_activity.dart';

class OneDay extends StatefulWidget {
  const OneDay({Key? key}) : super(key: key);

  @override
  State<OneDay> createState() => _OneDayState();
}

class _OneDayState extends State<OneDay> {
  TextEditingController textarea = TextEditingController();
  final _requestActivity = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    textarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userC = Get.put(UserController());
    // final inAct = Get.put(ActController());

    final DateTime dateTame = DateTime.now();
    final String formattedDate =
        DateFormat('dd.MM.yyyy, HH:mm').format(dateTame);
    var user = AppUtils.getUser();

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilderDateTimePicker(
              name: 'izindate',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Tanggal tidak boleh kosong';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Tanggal',
                prefixIcon: Icon(
                  Icons.calendar_today_rounded,
                  color: mainColor,
                ),
              ),
              inputType: InputType.date,
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'alasan',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Alasan tidak boleh kosong  ';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Alasan',
                prefixIcon: Icon(
                  Icons.text_decrease,
                  color: mainColor,
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BasicButton(
                basicText: 'Simpan',
                onPressed: _requestActivity.loading.value
                    ? null
                    : () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          var formData = _formKey.currentState!.value;
                          await _requestActivity.saveActivity(StatusActivity.izin, {
                            "izindate": formData['izindate'],
                            "alasan": formData['alasan'],
                          });
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                isLoading: _requestActivity.loading.value,
                loadingText: 'Memproses',
                color: mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
