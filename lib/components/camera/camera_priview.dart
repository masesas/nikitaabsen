import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/components/form/clock_in_form.dart';
import 'package:nikitaabsen/services/face.service.dart';
import 'package:nikitaabsen/utils/app_config.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class CameraPriviewIn extends StatefulWidget {
  const CameraPriviewIn({Key? key, this.filePath}) : super(key: key);
  final XFile? filePath;

  @override
  State<CameraPriviewIn> createState() => _CameraPriviewInState();
}

class _CameraPriviewInState extends State<CameraPriviewIn> {
  bool willpop = true;
  var user = AppUtils.getUser();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Preview'),
            elevation: 0,
            backgroundColor: mainColor,
            actions: [
              IconButton(
                  onPressed: () async {
                    bool isRecognized =
                        await handleClockInCallback(widget.filePath!);
                    if (!isRecognized) {
                      return;
                    }
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ClockInForm(
                          filePath: widget.filePath!.path,
                          userId: user.id!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check)),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.cached_outlined))
            ],
          ),
          extendBodyBehindAppBar: false,
          body: Center(
              child: Image(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  image: widget.filePath == null
                      ? const AssetImage("assets/images/landscape.png")
                      : FileImage(File(widget.filePath!.path))
                          as ImageProvider)),
        ),
        onWillPop: () async {
          return willpop;
        });
  }

  Future<bool> handleClockInCallback(XFile file) async {
    EasyLoading.show();

    var user = AppUtils.getUser();

    if (user.photo?.isEmpty ?? false) {
      EasyLoading.showError(
          'Foto profil belum diterapkan, silahkan hubungi administrator');
      return false;
    }

    var formdata = dio.FormData.fromMap({
      'user_id': user.id,
      'name': user.fullname,
      'photo': await AppUtils.createMultipart(file.path),
      'ref_photo': "${AppConfig.baseUrl}/uploads/${user.photo}"
    });

    try {
      final _response = await FaceService().recognize(formdata);
      if (_response.data!['_label'] == 'unknown') {
        EasyLoading.showError('Wajah tidak dikenali');
        return false;
      }
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      catchRecognitionError(e);
      return false;
    }
  }

  void catchRecognitionError(e) {
    if (e is dio.DioError) {
      if (e.response?.data != null) {
        var message = e.response!.data['message'];
        if (message == 'no face detected') {
          message = 'Wajah tidak terdeteksi';
          EasyLoading.showError(message);
          return;
        }
        EasyLoading.showError('Maaf terjadi kesalahan pada server');
        return;
      }
      EasyLoading.showError('Maaf terjadi kesalahan pada server');
      return;
    }
    EasyLoading.showError('Maaf terjadi kesalahan pada server');
    return;
  }
}
