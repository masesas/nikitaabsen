import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../../components/button/basic_button.dart';
import '../../utils/constants.dart';
import 'hari_kerja.controller.dart';
import 'hari_kerja.dart';

class NewJadwal extends StatefulWidget {
  const NewJadwal({Key? key}) : super(key: key);

  @override
  State<NewJadwal> createState() => _NewJadwalState();
}

final TextEditingController _harikerja = TextEditingController();

class _NewJadwalState extends State<NewJadwal> {
  String value = '';
  List<S2Choice<String>> options = [
    S2Choice<String>(value: '1', title: 'Tetap'),
    S2Choice<String>(value: '3', title: 'Flexibel'),
  ];

  @override
  Widget build(BuildContext context) {
    final states = Get.put(HariKerjaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Jadwal Kerja Baru"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BasicButton(
          basicText: 'Simpan',
          color: mainColor,
          onPressed: states.handleSubmitSchedule,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          color: Colors.transparent,
          child: FormBuilder(
            key: states.newJadwalFormKey,
            child: Column(
              children: <Widget>[
                SmartSelect<String>.single(
                  modalType: S2ModalType.bottomSheet,
                  modalDividerBuilder: (context, value) => const Divider(),
                  choiceDivider: true,
                  title: 'Tipe jadwal',
                  choiceItems: options,
                  onChange: (state) => states.onChangeTipeJadwal(state.value),
                  selectedValue: states.selectedTipe.value,
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
                    //   builder: (context) => const Harikerja(),
                    // );

                    await Get.to(const Harikerja());

                    int workDay = 0;
                    int offDay = 0;

                    // if (zz != null) {
                    //   var workDayResult = zz as Map<String, dynamic>;

                    states.selectedWorkday.forEach((key, value) {
                      if (value == '2') {
                        offDay += 1;
                      } else {
                        workDay += 1;
                      }
                    });
                    //}

                    _harikerja.text = '$workDay hari kerja, $offDay hari libur';
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
                  onChanged: (value) {},
                  name: 'effective_date',
                  maxLength: 70,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:  (value) {
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
