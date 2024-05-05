import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../../components/button/basic_button.dart';
import '../../models/schedule.dart';
import '../../models/workday.dart';
import '../../utils/constants.dart';
import '../edit_workdays/edit_workdays_page.dart';
import 'edit_schedule.controller.dart';

class EditSchedulePage extends StatefulWidget {
  const EditSchedulePage({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final Schedule schedule;

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  final TextEditingController _harikerja = TextEditingController();

  List<Workday> workdayList = [];

  int workday = 0;
  int offday = 0;
  String defaultType = "";

  @override
  void initState() {
    calculateWorkday();
    initDefaultSelectedType();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void calculateWorkday() {
    widget.schedule.workday?.forEach((element) {
      if (element.shiftingId == null) {
        setState(() {
          offday += 1;
        });
      } else {
        setState(() {
          workday += 1;
        });
      }

      _harikerja.text = '$workday hari kerja, $offday hari libur';
    });
  }

  void initDefaultSelectedType() {
    setState(() {
      defaultType = widget.schedule.type!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final states = Get.put(EditScheduleController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Jadwal Kerja"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BasicButton(
          basicText: 'Simpan',
          color: mainColor,
          onPressed: () => states.handleSubmitSchedule(widget.schedule.id!),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          color: Colors.transparent,
          child: FormBuilder(
            key: states.formKey,
            initialValue: {
              'nama_jadwal': widget.schedule.name,
              'effective_date': DateTime.parse(widget.schedule.effectiveDate!),
            },
            child: Column(
              children: <Widget>[
                SmartSelect<String>.single(
                  modalType: S2ModalType.bottomSheet,
                  modalDividerBuilder: (context, value) => const Divider(),
                  choiceDivider: true,
                  title: 'Tipe jadwal',
                  choiceItems: states.typeOptions,
                  onChange: (state) => states.onChangeTipeJadwal(state.value),
                  selectedValue: states.selectedTipe.value.isEmpty
                      ? widget.schedule.type!
                      : states.selectedTipe.value,
                ),
                IntrinsicHeight(
                  child: FormBuilderTextField(
                    name: 'nama_jadwal',
                    maxLength: 100,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:  (value) {
                      if (value == null  ) {
                        return 'Tidak Boleh Kosong ! ';
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
                      border: const UnderlineInputBorder(),
                      labelText: 'Nama Jadwal kerja',
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    // var zz = await showModalBottomSheet(
                    //   context: context,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (context) => EditWorkdaysPage(
                    //     workdayList: widget.schedule.workday,
                    //   ),
                    // );

                    await Get.to(
                        EditWorkdaysPage(workdayList: widget.schedule.workday));

                    int selectedWorkday = 0;
                    int selectedOffday = 0;

                    // if (zz != null) {
                    //   var workDayResult = zz as Map<String, dynamic>;

                    states.selectedWorkday.forEach((key, value) {
                      if (value == '2') {
                        selectedOffday += 1;
                      } else {
                        selectedWorkday += 1;
                      }
                    });

                    setState(() {
                      workday = selectedWorkday;
                      offday = selectedOffday;
                    });
                    // }

                    _harikerja.text = '$workday hari kerja, $offday hari libur';
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: AbsorbPointer(
                      child: FormBuilderTextField(
                        name: 'hari_kerja',
                        onSaved: (val) {},
                        controller: _harikerja,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Hari Kerja",
                          suffixIcon: Icon(Icons.arrow_forward_ios),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          print(value);

                          if (value == null) {
                            return "this field is required";
                          }

                          if (value.isEmpty) {
                            return 'Pilih hari kerja';
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  firstDate: DateTime.now(),
                  fieldHintText: 'Tanggal Mulai',
                  fieldLabelText: 'Tanggal Mulai',
                  name: 'effective_date',
                  maxLength: 70,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:   (value) {
                    if (value == null  ) {
                      return 'Tidak Boleh Kosong ! ';
                    }
                    return null;
                  } ,
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: mainColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    border: const UnderlineInputBorder(),
                    labelText: 'Tanggal Mulai',
                    // prefixIcon: Icon(
                    //   Icons.calendar_month,
                    //   color: mainColor,
                    // )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
