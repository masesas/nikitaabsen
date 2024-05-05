import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nikitaabsen/screens/home.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:nikitaabsen/utils/check_new_version.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/login.dart';
import 'utils/easy_loading/config_easy_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await initializeDateFormatting('id_ID');
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  configLoading();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.indigo.shade500,
  ));

  var initialScreen = await initializeScreen();
  runApp(MyApp(initialScreen: initialScreen));
}

Future<Widget> initializeScreen() async {
  final box = GetStorage();
  if (box.read('user') != null) {
    return const HomeScreen();
  }
  return const LoginScreen();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  final Widget initialScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nikita Attendance',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.white,
        ),
        home: initialScreen,
        builder: EasyLoading.init(),
      ),
    );
  }
}
