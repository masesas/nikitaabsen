import '../api/main.dart';
import '../models/response/app_config_response.dart';
import '../utils/app_config.dart';

class AppConfigService {
  static AppConfigService? _instance;
  factory AppConfigService() => _instance ??= AppConfigService._();
  AppConfigService._();

  Future<AppConfigResponse> get() async {
    var appConfigId = AppConfig.appConfigId;
    final res = await Api().dio.get("/app-config/$appConfigId");
    var config = AppConfigResponse.fromJson(res.data);
    return config;
  }
}
