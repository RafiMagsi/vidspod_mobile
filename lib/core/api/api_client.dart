import 'package:dio/dio.dart';
import 'package:vidspod_mobile/app/config.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(baseUrl: Config.apiUrl)) {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    // Here we can add interceptors for authentication, error handling, etc.
  }

  Dio get dio => _dio;
}
