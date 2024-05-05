import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/button/basic_button.dart';
import '../../components/show_dialog_cupertino/show_dialog.dart';
import '../../controllers/request_activity.controller.dart';
import '../../models/request/shift_request.dart';
import '../../models/shifting.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class EditJamKerja extends StatefulWidget {
  const EditJamKerja({Key? key, this.shiftResponse}) : super(key: key);

  final Shifting? shiftResponse;

  @override
  State<EditJamKerja> createState() => _EditJamKerjaState();
}

class _EditJamKerjaState extends State<EditJamKerja> {
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinputout = TextEditingController();
  TextEditingController namaout = TextEditingController();
  final shiftCont = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    print(widget.shiftResponse);
    var formData = _formKey.currentState?.value;
    print(formData);
    timeinput.text = widget.shiftResponse?.from ?? "";
    timeinputout.text = widget.shiftResponse?.to ?? "";
    namaout.text = widget.shiftResponse?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buat Jam kerja Baru'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: FormBuilder(
            initialValue: const {
              'form': null,
              'to': null,
            },
            key: _formKey,
            child: Column(children: [
              IntrinsicHeight(
                child: FormBuilderTextField(
                  name: 'nama',
                  initialValue: namaout.text,
                  maxLength: 100,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:   (value) {
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
                    border: const OutlineInputBorder(),
                    labelText: 'Nama jam kerja',
                    prefixIcon: Icon(
                      Icons.note,
                      color: mainColor,
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: timeinput, //editing controller of this TextField
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: mainColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.timer,
                      color: mainColor,
                    ),
                    labelText: "Jam Masuk"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    //print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    // print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    //print(formattedTime); //output 14:59:00

                    setState(() {
                      timeinput.text = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: timeinputout, //editing controller of this TextField
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: mainColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.timer,
                      color: mainColor,
                    ),
                    labelText: "Jam Pulang"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    //print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    // print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    //print(formattedTime); //output 14:59:00

                    setState(() {
                      timeinputout.text = formattedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    _showMyDialog();
                  },
                  child: const Text(
                    'Hapus jam kerja',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              const SizedBox(height: 30),
              Obx(() => BasicButton(
                  color: mainColor,
                  onPressed: shiftCont.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            debugPrint(_formKey.currentState?.value.toString());
                            var formData = _formKey.currentState?.value;
                            var user = AppUtils.getUser();
                            var data = ShiftingRequest(
                                companyId: user.companyId,
                                name: formData?['nama'],
                                from: timeinput.text,
                                to: timeinputout.text);
                            await shiftCont.editJk(
                                data, context, widget.shiftResponse!.id!);
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                          }
                        },
                  basicText: 'Simpan Perubahan')),
            ]),
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return await showRoundedCupertinoDialogWithAction(
      ctx: context,
      title: "Peringatan", // user must tap button!
      content: "Jam kerja akan di hapus. Yakin ingin menghapus?",
      actions: <Widget>[
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Hapus'),
          onPressed: () async {
            await shiftCont.deleteJk(widget.shiftResponse!.id!, context);
            Get.back();
            Get.back(result: true);
          },
        ),
      ],
    );
  }
}
