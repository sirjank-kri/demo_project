import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('📤 REQUEST: ${options.method} ${options.uri}');
    // In a real app, you'd add auth tokens here:
    // options.headers['Authorization'] = 'Bearer your_token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('📥 RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}');
    print('   Message: ${err.message}');
    super.onError(err, handler);
  }
}