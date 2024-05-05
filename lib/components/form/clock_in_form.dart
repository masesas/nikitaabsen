import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/request_activity.controller.dart';
import '../../utils/constants.dart';

class ClockInForm extends StatefulWidget {
  const ClockInForm({
    Key? key,
    required this.filePath,
    required this.userId,
  }) : super(key: key);

  final String filePath;
  final String userId;

  @override
  State<ClockInForm> createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  final controller = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSelected = false;
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
          initialValue: {'time_in': formattedTime},
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'time_in',
                maxLength: 70,
                decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  border: const UnderlineInputBorder(),
                  labelText: 'Jam Absen',
                  prefixIcon: Icon(
                    Icons.alarm,
                    color: mainColor,
                  ),
                ),
                enabled: false,
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderDropdown(
                name: 'is_wfh',
                validator:  (value) {
                  if (value == null  ) {
                    return 'Pilih tipe absen';
                  }
                  return null;
                } ,
                decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  border: const UnderlineInputBorder(),
                  labelText: 'Tipe Absen',
                  prefixIcon: Icon(
                    Icons.auto_awesome_motion_sharp,
                    color: mainColor,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: false,
                    child: Text('Work From Office'),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text('Work From Home'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: FormBuilderTextField(
                  name: 'notes',
                  maxLength: 100,
                  maxLines: null,
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: mainColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Keterangan',
                    prefixIcon: Icon(
                      Icons.note,
                      color: mainColor,
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => MaterialButton(
                  disabledColor: Colors.indigo.shade300,
                  onPressed: controller.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            var formData = _formKey.currentState?.value;
                            await controller.handleIn(
                              widget.filePath,
                              widget.userId,
                              formData?['notes'],
                              formData?['is_wfh'],
                            );

                            debugPrint(_isSelected.toString());
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
                  child: controller.loading.value
                      ? const Text(
                          'Memproses',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      : const Text(
                          'Absen Masuk',
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
