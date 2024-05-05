import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/models/location_point_model.dart';
import 'package:nikitaabsen/models/radius_model.dart';
import 'package:nikitaabsen/models/response/location_point_response.dart';
import 'package:nikitaabsen/models/user.model.dart';
import 'package:nikitaabsen/services/location_point_service.dart';

class LocationFromController extends GetxController {
  var locPoints = RadiusModel().obs;
  var user = User().obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setLocationPoint();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  Future<void> setLocationPoint() async {
    print('from location point controller ');
    setLoading(true);
    var response = await LocationPoinService().findRadius();
    locPoints.value = response;
    //  debugPrint(jsonEncode(locPoints.value));
    setLoading(false);
  }

  RadiusModel getLoc() {
    var data = setLocationPoint();

    return locPoints.value;
  }
}
