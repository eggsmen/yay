// data_fetcher.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menttang/src/data/baseUrl.dart';

class DataFetcher {
  static Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(urlBase.url + '/chat-gpt/ask-stream/v1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': '김태윤 교수님께 안부메일 써줘'}),
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        print('Response: $responseBody');
        // 여기서 responseBody를 원하는 형태로 가공하거나 사용할 수 있습니다.
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}