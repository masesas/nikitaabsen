import 'dart:convert';

import 'package:nikitaabsen/api/main.dart';
import 'package:nikitaabsen/models/location_point_model.dart';
import 'package:nikitaabsen/models/radius_model.dart';
import 'package:nikitaabsen/models/response/location_point_response.dart';
import 'package:nikitaabsen/utils/app_utils.dart';

class LocationPoinService {
  static LocationPoinService? _instance;
  factory LocationPoinService() => _instance ?? LocationPoinService._();
  LocationPoinService._();

  Future<LocationPointModel> findLoc() async {
    var loc = AppUtils.getLocPoint();
    final res = await Api().dio.get("/location-point/${loc.id}");
    var locPoint = LocationPointModel.fromJson(res.data);
    print(jsonEncode(res));
    return locPoint;
  }

  Future<RadiusModel> findRadius() async {
    var user = AppUtils.getRadius();
    final res = await Api().dio.get("/company-setting/${user.companyId}");
    var locPoint = RadiusModel.fromJson(res.data);
    //print("form service $res");
    return locPoint;
  }
}
