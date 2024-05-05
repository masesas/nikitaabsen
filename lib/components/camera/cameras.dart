import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Cameras extends StatefulWidget {
  const Cameras({
    Key? key,
  }) : super(key: key);

  @override
  State<Cameras> createState() => CamerasState();
}

class CamerasState extends State<Cameras> {
  CameraController? cameraController;
  List? cameras;
  late int selectedCameraIdx;
  XFile? imagePath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.length > 0) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                      color: Colors.white,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        // side: BorderSide(color: Colors.blueAccent, width: 1.5),
                      ),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(
                              color: Colors.blueAccent, width: 2.5),
                        ),
                        onTap: () async {
                          final XFile file =
                              await cameraController!.takePicture();
                          if (!mounted) {
                            return;
                          }
                          Navigator.pop(context, file);
                          // EasyLoading.show(status: 'loading...');
                        },
                        child: Image.asset('assets/images/aperture.png'),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cameraPreview(context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: Text(
          "LOADING",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w900),
        ),
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
                    fit: BoxFit.fitWidth)),
          )
        ],
      ),
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

  Future _onCapturePresses() async {
    XFile imagePath = await cameraController!.takePicture();
    print(imagePath);
  }
}
