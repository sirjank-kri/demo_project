import 'package:dio/dio.dart';
import 'api_interceptor.dart';
import '../constants/api_constants.dart';

class ApiClient {
  // 🟢 SINGLETON PATTERN - only one instance ever exists
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    // Attach the interceptor
    dio.interceptors.add(ApiInterceptor());
  }
}