import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthenticationApi {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  register(
      {required String user,
      required String email,
      required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await _dio.post(
        'http://localhost:3000/api/auth/register',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'user': user,
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } catch (e) {
      _logger.e(e);
    }
  }
}
