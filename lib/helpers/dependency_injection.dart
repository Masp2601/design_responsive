import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../api/authentication_api.dart';
import 'http.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(BaseOptions(baseUrl: 'https://coldchaincolombia.com'));
    Logger logger = Logger();

    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );
    final AuthenticationApi authenticationApi = AuthenticationApi(http);

    GetIt.instance.registerSingleton<AuthenticationApi>(authenticationApi);
  }
}
