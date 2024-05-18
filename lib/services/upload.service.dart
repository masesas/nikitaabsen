import 'package:dio/dio.dart';

import '../api/main.dart';

class UploadService {
  static UploadService? _instance;
  factory UploadService() => _instance ??= UploadService._();
  UploadService._();

  /// return [String] fsavename as unique id for uploading image
  Future<String?> create(FormData data) async {
    final response = await Api().dio.post("/api.sendimage", data: data);
    final responseData = response.data as Map<String, dynamic>;
    final isSuccess = (responseData['fsavename'] as String?) != null;

    if (isSuccess) {
      return responseData['fsavename'];
    }

    throw Exception('Failed to upload image');
  }
}
