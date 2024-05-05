import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:nikitaabsen/models/response/response_image.dart';
import 'package:nikitaabsen/utils/app_utils.dart';

import '../api/main.dart';
import '../models/response/upload_response.model.dart';

class UploadService {
  static UploadService? _instance;
  factory UploadService() => _instance ??= UploadService._();
  UploadService._();

  Future<UploadResponse> create(var data) async {
    final response = await Api().dio.post("/upload", data: data);
    final uploadResponse = UploadResponse.fromJson(response.data);
    print('sss $uploadResponse');
    return uploadResponse;
  }
}
