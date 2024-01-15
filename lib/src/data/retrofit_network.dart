import 'dart:convert';
import 'package:eventsource/eventsource.dart';
import 'package:menttang/src/data/baseUrl.dart';

class DataFetcher {
  static Stream<String> fetchDataStream() async* {
    try {
      // 쿼리 파라미터를 URL에 추가
      final url = Uri.parse(urlBase.url + '/chat-gpt/ask-stream/v1');

      // EventSource 연결 설정 (요청 본문 없음)
      final eventSource = await EventSource.connect(url, headers: {
        'Content-Type': 'application/json'}, body: jsonEncode({'question': '김태윤 교수님께 성적 정정메일을 작성해줘'}));

      await for (final event in eventSource) {
        yield event.data ?? 'Default value';  // 'Default value'를 적절한 대체 문자열로 교체
      }

    } catch (e, stacktrace) {
      // 오류와 스택 트레이스 출력
      print('Error: $e');
      print('Stacktrace: $stacktrace');
      yield 'Error: $e';
    }
  }
}