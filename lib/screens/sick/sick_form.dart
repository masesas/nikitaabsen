import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/components/camera/back_camera.dart';
import 'package:nikitaabsen/components/camera/cameras.dart';
import 'package:nikitaabsen/components/camera/custom_camera.dart';
import 'package:nikitaabsen/components/form/clock_in_form.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/faces/nikitaface.dart';
import 'package:nikitaabsen/models/request/izin_request.model.dart';
import 'package:nikitaabsen/models/request/izin_sakit.dart';
import 'package:nikitaabsen/models/user.model.dart';
import 'package:nikitaabsen/models/user_sick_document.model.dart';
import 'package:nikitaabsen/services/face.service.dart';
import 'package:nikitaabsen/services/upload.service.dart';
import 'package:nikitaabsen/utils/app_config.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class IzinSakitFrom extends StatefulWidget {
  const IzinSakitFrom({Key? key, this.imagePath}) : super(key: key);

  final XFile? imagePath;

  @override
  State<IzinSakitFrom> createState() => _IzinSakitFromState();
}

class _IzinSakitFromState extends State<IzinSakitFrom> {
  final _requestActivity = Get.put(RequestActivityController());
  final _formKey = GlobalKey<FormBuilderState>();
  var user = AppUtils.getUser();
  String? _from;
  String? _to;
  bool isPasswordVisible = false;

  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  XFile? imagePath;

  var error = false.obs;
  var message = ''.obs;
  setErrorAndMessage(bool value, String errorMsg) {
    error.value = value;
    message.value = errorMsg;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: MediaQuery.of(context).padding,
      child: Container(
        child: SingleChildScrollView(
          child: FormBuilder(
            initialValue: {
              'from': null,
              'to': null,
            },
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sakit lebih 1 hari",
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'WorkSans-Bold',
                      fontWeight: FontWeight.w400),
                ),
                FormBuilderDateRangePicker(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 7)),
                  fieldStartHintText: 'Dari',
                  fieldStartLabelText: 'Dari',
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const UnderlineInputBorder(),
                    labelText: 'Pilih Tanggal',
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: mainColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    color: Colors.green.shade200,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imageProfile(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => BasicButton(
                      color: mainColor,
                      onPressed: _requestActivity.loading.value
                          ? null
                          : () async {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                if (_from != null) {
                                  if (imagePath != null) {
                                    var formData = _formKey.currentState?.value;
                                    var usera = AppUtils.getUser();

                                    var datssa =
                                        await _requestActivity.izinSakit(
                                            'SAKIT',
                                            usera.id.toString(),
                                            _from!,
                                            _to!,
                                            imagePath!);
                                  } else {
                                    EasyLoading.showError(
                                        'Bukti Sakit Wajib Diupload!');
                                  }
                                } else {
                                  EasyLoading.showError(
                                      'Tanggal Tidak Boleh Kosong');
                                }

                                //  Get.snackbar('ss', 'message');
                              } else {
                                debugPrint(
                                    _formKey.currentState?.value.toString());
                                debugPrint('validation failed');
                              }
                            },
                      basicText: 'Simpan',
                      isLoading: _requestActivity.loading.value,
                      loadingText: 'Memproses',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Column(children: <Widget>[
        Image(
            width: 200,
            image: imagePath == null
                ? const AssetImage("assets/images/landscape.png")
                : FileImage(File(imagePath!.path)) as ImageProvider),
        const SizedBox(
          height: 20,
        ),
        BasicButton(
            onPressed: () async {
              XFile? imageFromCamera = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BackCamera()));
              if (imageFromCamera != null) {
                setState(() {
                  imagePath = imageFromCamera;
                });
              }
            },
            basicText: 'Foto Bukti Sakit',
            color: mainColor)
      ]),
    );
  }
}
