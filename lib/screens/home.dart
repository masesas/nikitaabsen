import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/controllers/activity.controller.dart';
import 'package:nikitaabsen/controllers/request_activity.controller.dart';
import 'package:nikitaabsen/facedetectionview.dart';
import 'package:nikitaabsen/person.dart';
import 'package:nikitaabsen/utils/status_activity.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../components/button/basic_button.dart';
import '../components/camera/custom_camera.dart';
import '../components/card/menu_card.dart';
import '../components/clock_card.dart';
import '../components/form/clock_in_form.dart';
import '../components/form/clock_out_form.dart';
import '../components/form/form_overtime.dart';
import '../components/form/izin_form.dart';
import '../controllers/auth.controller.dart';
import '../controllers/home.controller.dart';
import '../models/user.model.dart';
import '../services/face.service.dart';
import '../utils/app_config.dart';
import '../utils/app_utils.dart';
import '../utils/check_new_version.dart';
import '../utils/constants.dart';
import '../utils/geolocator/get_location.dart';
import 'activity_history.dart';
import 'downliner_activity_history.dart';
import 'schedule/schedule_setting_page.dart';
import 'sick/sick_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final activityController = Get.put(ActivityController({}));
  final controller = Get.put(HomeController());
  final requestActivityController = Get.put(RequestActivityController());
  
  var locpointss = AppUtils.getLocPoint();
  var radius = AppUtils.getRadius();

  @override
  void initState() {
    super.initState();

    versionCheck();
    determinePosition();
    _initOneSignal();
  }

  Future<void> _initOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    String appId = AppConfig.oneSignalKey;

    OneSignal.shared.setAppId(appId);

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {});

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    var userId = AppUtils.getUser().id;

    OneSignal.shared.setExternalUserId(userId.toString()).then((results) {
      log(results.toString());
    }).catchError((error) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final menu = [
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/check_in.png',
          title: 'Riwayat',
          subTitle: 'Lihat riwayat absensi kamu.',
          onTap: () {
            Get.to(const ActivityHistoryScreen());
          },
        ),
      },
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/listpict.png',
          title: 'Checkin',
          subTitle: 'Absen masuk harian kamu.',
          onTap: () async {
            await _absen(activity: StatusActivity.checkin);
            //EasyLoading.showInfo("Fitur ini segera hadir");
            //Get.to(const DownlinerActivityHistory());
          },
        )
      },
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/calendar.png',
          title: 'Checkout',
          subTitle: 'Absen keluar harian kamu',
          onTap: () async {
            await _absen(activity: StatusActivity.checkout);
            //Get.to(const ScheduleSettingPage());
            //EasyLoading.showInfo("Fitur ini segera hadir");
          },
        ),
      },
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/attendance.png',
          title: 'Cuti',
          subTitle: 'Ajukan permintaan cuti kamu disini.',
          onTap: () {
            showModalBottomSheet(
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
                child: const IzinForm(),
              ),
            );
          },
        ),
      },
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/clock-out.png',
          title: 'Lembur',
          subTitle: 'Ajukan permintaan lembur kamu disini.',
          onTap: () {
            EasyLoading.showInfo("Fitur ini segera hadir");
            /*  showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: ((context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: OvertimeScreen(),
                    ))); */
          },
        ),
      },
      {
        'is_leader': false,
        'component': MenuCard(
          imagePath: 'assets/images/patient.png',
          title: 'Sakit',
          subTitle: 'Beri tahu atasanmu jika kamu sedang sakit.',
          onTap: () {
            Get.to(() => const SickScreen());
          },
        ),
      }
    ];

    List<Widget> menus = [];

    for (var element in menu) {
      final isLeader = element['is_leader'] as bool;
      final widget = element['component'] as Widget;

      if (isLeader) {
        if (AppUtils.checkLevel(AppUtils.getUser().jobLevel?.level)) {
          menus.add(widget);
        }
        continue;
      }
      menus.add(widget);
    }

    return Obx(
      () => Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BasicButton(
              basicText: 'Logout',
              color: mainColor,
              onPressed: () async => await AuthController().handleLogout()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          margin: MediaQuery.of(context).padding,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.getCurrentUser();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade500,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 15, top: 20),
                          child: _buildHeader(
                            companyName: null,
                            userName: controller.profile['name'] ?? 'Akun Demo',
                            jobLevel: controller.user.value.jobLevel?.name,
                            jobDepartment:
                                controller.user.value.jobDepartement?.name,
                          ),
                        ),
                        ClockCard(
                          user: controller.user.value,
                          profile: controller.profile,
                          onPressedClockIn: () async => await _absen(),
                          onPressedClockOut: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: const ClockOutForm(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GridView(
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      primary: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            MediaQuery.of(context).devicePixelRatio * 0.35,
                      ),
                      children: menus
                      // [
                      //   MenuCard(
                      //     imagePath: 'assets/images/check_in.png',
                      //     title: 'Riwayat',
                      //     subTitle: 'Lihat riwayat absensi kamu.',
                      //     onTap: () {
                      //       Get.to(const ActivityHistoryScreen());
                      //     },
                      //   ),
                      //   AppUtils.checkLevel(null)
                      //       ? MenuCard(
                      //           imagePath: 'assets/images/listpict.png',
                      //           title: 'Monitor',
                      //           subTitle: 'Monitor aktivitas tim kamu.',
                      //           onTap: () {
                      //             Get.to(const DownlinerActivityHistory());
                      //           },
                      //         )
                      //       : Container(),
                      //   MenuCard(
                      //     imagePath: 'assets/images/calendar.png',
                      //     title: 'Atur Jadwal',
                      //     subTitle: 'Monitor aktivitas tim kamu.',
                      //     onTap: () {
                      //       Get.to(const ScheduleSettingPage());
                      //     },
                      //   ),
                      //   MenuCard(
                      //     imagePath: 'assets/images/attendance.png',
                      //     title: 'Cuti',
                      //     subTitle: 'Ajukan permintaan cuti kamu disini.',
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         context: context,
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(20),
                      //             topRight: Radius.circular(20),
                      //           ),
                      //         ),
                      //         builder: (context) => Padding(
                      //           padding: EdgeInsets.only(
                      //               bottom:
                      //                   MediaQuery.of(context).viewInsets.bottom),
                      //           child: const IzinForm(),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      //   MenuCard(
                      //     imagePath: 'assets/images/clock-out.png',
                      //     title: 'Lembur',
                      //     subTitle: 'Ajukan permintaan lembur kamu disini.',
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //           isScrollControlled: true,
                      //           context: context,
                      //           shape: const RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(20),
                      //               topRight: Radius.circular(20),
                      //             ),
                      //           ),
                      //           builder: ((context) => Padding(
                      //                 padding: EdgeInsets.only(
                      //                     bottom: MediaQuery.of(context)
                      //                         .viewInsets
                      //                         .bottom),
                      //                 child: OvertimeScreen(),
                      //               )));
                      //     },
                      //   ),
                      //   MenuCard(
                      //     imagePath: 'assets/images/patient.png',
                      //     title: 'Sakit',
                      //     subTitle: 'Beri tahu atasanmu jika kamu sedang sakit.',
                      //     onTap: () {
                      //       Get.to(SickScreen());
                      //     },
                      //   ),
                      // ],
                      ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 12,
                  //     right: 12,
                  //     top: 10,
                  //     bottom: 15,
                  //   ),
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       Get.to(const LoginScreen());
                  //     },
                  //     color: const Color(0xffff2d55),
                  //     elevation: 0,
                  //     minWidth: 400,
                  //     height: 50,
                  //     textColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: const Text(
                  //       'Logout',
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> versionCheck() async {
    await checkNewVersion();
  }

  Widget _buildHeader({
    String? companyName,
    required String userName,
    String? jobLevel,
    String? jobDepartment,
  }) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (companyName != null)
              Text(companyName, style: const TextStyle(color: Colors.white)),
            if (companyName != null)
              const SizedBox(
                height: 10,
              ),
            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            companyName != null
                ? Text(
                    '$jobLevel $jobDepartment',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
          ],
        )
      ],
    );
  }

  Future handleClockInCallback(XFile file, User user) async {
    if (user.photo?.isEmpty ?? false) {
      EasyLoading.showError(
          'Foto profil belum diterapkan, silahkan hubungi administrator');
      return;
    }

    var formdata = dio.FormData.fromMap({
      'user_id': user.id,
      'name': user.fullname,
      'photo': await AppUtils.createMultipart(file.path),
      'ref_photo': "${AppConfig.baseUrl}/uploads/${user.photo}"
    });

    /* try {
      final _response = await FaceService().recognize(formdata);
      if (_response.data!['_label'] == 'unknown') {
        EasyLoading.showError('Wajah tidak dikenali');
        Navigator.pop(context);
        return;
      }
      EasyLoading.dismiss();
      Navigator.pop(context, file);
    } catch (e) {
      catchRecognitionError(e);
      Navigator.pop(context);
      return;
    } */
  }

  void catchRecognitionError(e) {
    if (e is dio.DioError) {
      if (e.response?.data != null) {
        var message = e.response!.data['message'];
        if (message == 'no face detected') {
          message =
              'Wajah tidak terdeteksi, mohon lakukan selfie ditempat bercahaya';
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

  Future<void> _absen({StatusActivity? activity}) async {
    await controller.determinePosition();
    if (mounted) {
      final bytes = await Navigator.push(
        context,
        /*MaterialPageRoute(
          builder: (context) => CustomCamera(
            file: (file) async =>
                await handleClockInCallback(file, controller.user.value),
          ),
        ),*/

        MaterialPageRoute(builder: (context) => FaceRecognitionView()),
      );

      if (bytes != null) {
        final absenType = controller.nextStatusAttendace.value;
        final tempDir = await path_provider.getTemporaryDirectory();
        File file =
            await File('${tempDir.path}/absen-$absenType-${DateTime.now()}.png')
                .create();
        file.writeAsBytesSync(bytes);
        requestActivityController.saveActivity(
          activity ??
              (controller.nextStatusAttendace.value == 'CHECKOUT'
                  ? StatusActivity.checkout
                  : StatusActivity.checkin),
          {
            "selfie": file.path,
          },
        );
        /* showModalBottomSheet(
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
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: ClockInForm(
                                    filePath: file.path,
                                    userId: controller.user.value.id!,
                                  ),
                                ),
                              ); */
      } else {
        EasyLoading.showError('Wajah tidak dikenali');
      }
    }
  }

  // Future<bool> _getDistance() async {
  //   final controller = Get.put(LocationFromController());
  //   if (user.locationPoint == null) {
  //     return false;
  //   }
  //   final currenPosition = await determinePosition();
  //   var userlat = user.locationPoint!.latitude!;
  //   var userlong = user.locationPoint!.longitude!;
  //   var maxradius = radius.maxRadius;

  //   var des = AppUtils.getRadius();
  //   //debugPrint(jsonEncode(controller));
  //   // debugPrint(jsonEncode(des));

  //   print(currenPosition.longitude);
  //   print(currenPosition.latitude);
  //   print(userlat);
  //   print(userlong);
  //   var response = await LocationPoinService().findRadius();

  //   print(response.maxRadius);

  //   //print(jsonEncode(response.maxRadius));

  //   var distanceInMeter = Geolocator.distanceBetween(-6.227201313377554,
  //       106.82860150669359, double.parse(userlat), double.parse(userlong));

  //   var distance = distanceInMeter.round().toInt();

  //   print('$distance M');
  //   // print(radius.maxRadius);

  //   return true;
  // }
}
