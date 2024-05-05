import 'package:dio/dio.dart';

import '../utils/app_config.dart';
import '../utils/app_utils.dart';
import 'api_interceptor.dart';

class FaceClient {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  FaceClient._internal();

  static final _singleton = FaceClient._internal();

  factory FaceClient() => _singleton;

  static Dio createDio() {
    var token = AppUtils.getToken();

    var dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.faceUrl,
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }
}
