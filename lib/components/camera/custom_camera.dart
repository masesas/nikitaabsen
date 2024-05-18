import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikitaabsen/faces/nikitaface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomCamera extends StatefulWidget {
  WebViewController? controller;
  CustomCamera({Key? key, this.file}) : super(key: key);

  final Future Function(XFile)? file;

  @override
  State<StatefulWidget> createState() => CustomCameraState();
}

class CustomCameraState extends State<CustomCamera> {
  CameraController? cameraController;
  List? cameras;
  late int selectedCameraIdx;
  String? imagePath;
  bool loading = true;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras?.isNotEmpty ?? false) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras![selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print("Error : $err.code\nError Message : $err.message");
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //NikitaFace(controller: widget.controller),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _cameraPreview(context),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 5.0,
              child: SizedBox(
                height: 100.0,
                width: 100.0,
                child: Material(
                  color: Colors.transparent,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    // side: BorderSide(color: Colors.blueAccent, width: 1.5),
                  ),
                  child: Builder(builder: (context) {
                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: Colors.blueAccent, width: 2.5),
                      ),
                      onTap: () async {
                        //EasyLoading.show(status: 'Memproses...');
                        final file = await cameraController!.takePicture();
                        /* debugPrint(file.path);
                          await cameraController!.pausePreview(); */
                        //await widget.file!(file);
                        if (mounted) {
                          Navigator.pop(context, file);
                        }

                        /*  final String contentBase64 = base64Encode(await file.readAsBytes() );
                          widget.controller!.runJavaScriptReturningResult("  loadRef64('data:image/png;base64,$contentBase64' );"); */
                      },
                      child: Image.asset('assets/images/aperture.png'),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    final availableCamera = await availableCameras();
    final frontCam = availableCamera[1];

    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(frontCam, ResolutionPreset.veryHigh);

    cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController!.value.hasError) {
        print("Camera error ${cameraController!.value.errorDescription}");
      }
    });

    try {
      await cameraController!.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreview(context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return AspectRatio(
      aspectRatio: cameraController!.value.aspectRatio,
      child: Stack(
        children: <Widget>[
          CameraPreview(cameraController!),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/selfie_ktp_trans.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
