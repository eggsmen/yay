
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menttang/src/data/baseUrl.dart';

class DataFetcher {
  static Future<http.Response> fetchData({
    required String email,
    required String password,
    required String nickname,
  }) async {
    final response = await http.post(
      Uri.parse(urlBase.url + '/mail/send/v1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password, "nickname": nickname}),
    );

    return response;
  }
}

class checkAuth {
  static Future<http.Response> fetchData({
    required String email,
    required String authCode
  }) async {
    final response = await http.post(
      Uri.parse(urlBase.url + '/mail/auth-check/v1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "authCode": authCode}),
    );

    return response;
  }
}
