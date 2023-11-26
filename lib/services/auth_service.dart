import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../configs/api_routes.dart';
import '../utils/app_exception.dart';

import '../utils/http_client.dart';

class AuthService {
  static loginModerator(String username, String password) async {
    var url = ApiRoutes.moderatorLogin;
    try {
      var payload = json.encode({'username': username, 'password': password});
      var response = await HttpClient.post(url, payload, isAuthenticationRequired:false);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }
}
