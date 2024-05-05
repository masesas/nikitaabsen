import 'package:dio/dio.dart';

import '../api/face_client.dart';

class FaceService {
  static FaceService? _instance;
  factory FaceService() => _instance ??= FaceService._();
  FaceService._();

  Future<Response> recognize(var data) async {
    final response = await FaceClient().dio.post("/recognize", data: data);
    return response;
  }
}
