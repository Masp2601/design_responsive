// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart' show required;

class HttpResponse {
  final dynamic data;
  final dynamic error;

  HttpResponse(this.data, this.error);

  static HttpResponse success(dynamic data) {
    return HttpResponse(data, null);
  }

  static HttpResponse fail(
          {required int statusCode,
          @required dynamic data,
          required String message}) =>
      HttpResponse(
        null,
        HttpError(statusCode as String, data, message),
      );
}

class HttpError {
  final String message;
  final int statusCode;
  final dynamic data;

  HttpError(this.message, this.statusCode, this.data);
}
