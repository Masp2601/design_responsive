import '../helpers/http.dart';
import '../helpers/http_response.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<HttpResponse> register(
      {required String user, required String email, required String password}) {
    return _http.request(
      '/api/auth/register',
      method: "POST",
      data: {
        'user': user,
        'email': email,
        'password': password,
      },
    );
  }

  Future<HttpResponse> login(
      {required String user, required String password}) async {
    return _http.request(
      '/api/auth/login',
      method: "POST",
      data: {
        'user': user,
        'password': password,
      },
    );
  }
}
