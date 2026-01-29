import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../utils/logger.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.newsApiBaseUrl,
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.api('Request: ${options.method} ${options.uri}');
          logger.d('Headers: ${options.headers}');
          logger.d('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.api('Response: ${response.statusCode} ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (error, handler) {
          logger.e(
            'Error: ${error.response?.statusCode} ${error.requestOptions.uri}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
