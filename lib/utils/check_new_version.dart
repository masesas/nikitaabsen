import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_utils.dart';

Future<void> checkNewVersion() async {
  String? newVersion = await AppUtils.hasNewVersion();

  if (newVersion != null) {
    return Get.dialog(
      CupertinoAlertDialog(
        title: const Text(
          'Versi baru tersedia',
          textAlign: TextAlign.center,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              if (!await launchUrl(Uri.parse(newVersion),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $newVersion';
              }
            },
            child: const Text(
              'Update',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).then((value) => SystemNavigator.pop());
  }
}
