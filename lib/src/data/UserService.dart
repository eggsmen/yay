import 'package:menttang/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menttang/src/data/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  static Future<http.Response> login({required String email, required String password}) async {
    var url = Uri.parse(urlBase.url + '/user/login/v1'); // 실제 API URL로 변경

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response;
  }
}
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

class CustomMailSend {
  static Future<http.Response> fetchData({
    required String toMail,
    required String subject,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse(urlBase.url+'/mail/send-custom/v1?userId=$userId'),
      // Uri.parse(urlBase.url+'/mail/send-custom/v1').replace(queryParameters:{
      //   'userId': userId}),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"toMail": toMail, "subject": subject, "content": content}),

    );

    return response;
  }
}

