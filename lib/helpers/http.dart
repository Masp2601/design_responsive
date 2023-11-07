import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'http_response.dart';

class Http {
  final Dio _dio;
  final Logger _logger;
  final bool _logsEnabled;

  Http({
    required Dio dio,
    required Logger logger,
    required bool logsEnabled,
  })  : _dio = dio,
        _logger = logger,
        _logsEnabled = logsEnabled;

  Future<HttpResponse> request(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
      );
      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e);
      int statusCode = -1;
      String? message = '';
      dynamic data;

      if (e is DioException) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data;
        }
      }
      return HttpResponse.fail(
          statusCode: statusCode, data: data, message: message!);
    }
  }
}
