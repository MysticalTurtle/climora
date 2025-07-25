import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioInstance {
  late Dio dioInstance;

  Future<Dio> getDioInstance({
    required FlutterSecureStorage secureStorage,
  }) async {
    dioInstance =
        Dio(
            BaseOptions(),
          )
          ..options.baseUrl = 'https://api.openweathermap.org'
          ..options.followRedirects = false;

    setConnectTimeout(
      const Duration(seconds: 15),
    );
    setReceiveTimeout(
      const Duration(seconds: 15),
    );
    _addLogInterceptor();
    _addRetryInterceptor();
    _addCacheInterceptor();

    return dioInstance;
  }

  void setConnectTimeout(Duration duration) {
    dioInstance.options.connectTimeout = duration;
  }

  void setReceiveTimeout(Duration duration) {
    dioInstance.options.receiveTimeout = duration;
  }

  void _addRetryInterceptor() {
    dioInstance.interceptors.add(
      RetryInterceptor(
        dio: dioInstance,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    );
  }

  void _addLogInterceptor() {
    dioInstance.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  void _addCacheInterceptor() {
    dioInstance.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}
