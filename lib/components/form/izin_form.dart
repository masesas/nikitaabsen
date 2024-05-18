import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:nikitaabsen/utils/status_activity.dart';

import '../../controllers/leave_form.controller.dart';
import '../../controllers/request_activity.controller.dart';
import '../../models/request/izin_request.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../button/basic_button.dart';

class IzinForm extends StatefulWidget {
  const IzinForm({Key? key}) : super(key: key);

  @override
  State<IzinForm> createState() => _IzinFormState();
}

class _IzinFormState extends State<IzinForm> {
  final _requestActivity = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();
  /*  String? _from;
  String? _to;
  bool isPasswordVisible = false;
  final controller = Get.put(LeaveFormController()); */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: MediaQuery.of(context).padding,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              /* FormBuilderDropdown(
                  name: 'leave_type_id',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih tipe cuti';
                    }
                    return null;
                  },
                  /* FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Pilih tipe cuti'),
                        ]),*/
                  items: controller.leaveTypes.value.data!
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name ?? ''),
                            value: e.id,
                          ))
                      .toList(),
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
                    labelText: 'Tipe Cuti',
                    prefixIcon: Icon(
                      Icons.auto_awesome_motion_sharp,
                      color: mainColor,
                    ),
                  ),
                ) */
              /* FormBuilderDateRangePicker(
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  fieldStartHintText: 'Dari',
                  fieldStartLabelText: 'Dari',
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih tanggal cuti';
                    }
                    return null;
                  },
                  onChanged: (_value) {
                    debugPrint(_value?.start.toIso8601String());
                    setState(() {
                      _from = _value?.start.toIso8601String();
                      _to = _value?.end.toIso8601String();
                    });
                  },
                  name: 'date_range',
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
                    labelText: 'Tanggal Cuti',
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: mainColor,
                    ),
                  ),
                ), */
              FormBuilderDateTimePicker(
                name: 'cutidate',
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
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: FormBuilderTextField(
                  name: 'notes',
                  maxLength: 100,
                  maxLines: null,
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
                    labelText: 'Keterangan',
                    prefixIcon: Icon(
                      Icons.calendar_today_rounded,
                      color: mainColor,
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Obx(
                () => BasicButton(
                  color: mainColor,
                  onPressed: _requestActivity.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            var formData = _formKey.currentState!.value;

                            await _requestActivity
                                .saveActivity(StatusActivity.cuti, {
                              "cutidate": formData["cutidate"],
                            });
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                  basicText: 'Ajukan',
                  isLoading: _requestActivity.loading.value,
                  loadingText: 'Memproses',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
