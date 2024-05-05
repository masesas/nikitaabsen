import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/models/request/overtime_request.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:intl/intl.dart';

class OvertimeScreen extends StatefulWidget {
  const OvertimeScreen({Key? key}) : super(key: key);

  @override
  State<OvertimeScreen> createState() => _OvertimeScreenState();
}

class _OvertimeScreenState extends State<OvertimeScreen> {
  final inAct = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();
  String? _from;
  String? _to;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: MediaQuery.of(context).padding,
      child: SingleChildScrollView(
        child: FormBuilder(
          initialValue: const {
            'from': null,
            'to': null,
          },
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              FormBuilderDateTimePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
                fieldHintText: 'Dari',
                fieldLabelText: 'Dari',
                onChanged: (value) {
                  debugPrint(value?.toIso8601String());
                  setState(() {
                    _from = value?.toIso8601String();
                  });
                },
                name: 'timeIn',
                maxLength: 70,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:  (value) {
                  if (value == null  ) {
                    return 'Tidak Boleh Kosong !';
                  }
                  return null;
                } ,
                decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: mainColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Jam Mulai',
                    prefixIcon: Icon(
                      Icons.timer,
                      color: mainColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderDateTimePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 1)),
                fieldHintText: 'Sampai',
                fieldLabelText: 'Sampai',
                onChanged: (value) {
                  debugPrint(value?.toIso8601String());
                  setState(() {
                    _to = value?.toIso8601String();
                  });
                },
                name: 'timeOut',
                maxLength: 70,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:   (value) {
                  if (value == null  ) {
                    return 'Tidak Boleh Kosong !';
                  }
                  return null;
                } ,
                decoration: InputDecoration(
                    counterText: " ",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Jam Akhir',
                    prefixIcon: Icon(
                      Icons.timer,
                      color: mainColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: FormBuilderTextField(
                  name: 'notes',
                  maxLength: 100,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:   (value) {
                    if (value == null  ) {
                      return 'Tidak Boleh Kosong !';
                    }
                    return null;
                  } ,
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
              Obx(() => BasicButton(
                    color: mainColor,
                    onPressed: inAct.loading.value
                        ? null
                        : () async {
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              debugPrint(
                                  _formKey.currentState?.value.toString());
                              var formData = _formKey.currentState?.value;
                              var user = AppUtils.getUser();
                              var data = overtimeRequest(
                                  requestType: "OVERTIME_IN",
                                  userId: user.id,
                                  overtimeDateTo: _to,
                                  overtimeNote: formData?['notes']);
                              await inAct.handleOvertime(data);
                            } else {
                              debugPrint(
                                  _formKey.currentState?.value.toString());
                            }
                          },
                    basicText: 'Ajukan',
                    isLoading: inAct.loading.value,
                    loadingText: 'Memproses',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
