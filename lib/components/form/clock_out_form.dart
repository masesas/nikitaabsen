import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/request_activity.controller.dart';
import '../../utils/constants.dart';

class ClockOutForm extends StatefulWidget {
  const ClockOutForm({Key? key}) : super(key: key);

  @override
  State<ClockOutForm> createState() => _ClockOutFormState();
}

class _ClockOutFormState extends State<ClockOutForm> {
  final _requestActivity = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordVisible = false;
  late Timer _timer;
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        formattedTime = DateFormat('HH:mm').format(DateTime.now());
      });
      _formKey.currentState?.patchValue({'time_in': formattedTime});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: MediaQuery.of(context).padding,
      child: SingleChildScrollView(
        child: FormBuilder(
          initialValue: {'time_out': formattedTime},
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'time_out',
                maxLength: 70,
                decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  border: UnderlineInputBorder(),
                  labelText: 'Jam Keluar',
                  prefixIcon: Icon(
                    Icons.alarm,
                    color: mainColor,
                  ),
                ),
                enabled: false,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => MaterialButton(
                  disabledColor: Colors.indigo.shade300,
                  onPressed: _requestActivity.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            var formData = _formKey.currentState?.value;
                            await _requestActivity.handleOut();
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                  color: mainColor,
                  elevation: 0,
                  minWidth: 400,
                  height: 50,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _requestActivity.loading.value
                      ? const Text(
                          'Memproses',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      : const Text(
                          'Absen Pulang',
                          style: TextStyle(fontSize: 17),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
