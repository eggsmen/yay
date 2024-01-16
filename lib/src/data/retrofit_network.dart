import 'dart:async';
import 'package:sse/client/sse_client.dart';
import 'package:menttang/src/data/baseUrl.dart';
import 'package:menttang/src/pages/automail_page.dart';

class DataFetcher {
  static Stream<String> fetchDataStream() {

    final controller = StreamController<String>();

    try {
      final url = Uri.parse(urlBase.url+'/chat-gpt/ask-stream/v1')
          .replace(queryParameters: {
        'question': '너는 [전자과 20학번 박현규]야. [김태윤 교수님]께  [진로상담 신청]을 용건으로 [유학 프로세스가 궁금하다]를 설명하여 담아 연락처:[010-1234-5678] 를 포함하여 메일을 작성해줘. q: 친근한 말투로 작성해줘q: 겨울에 관련하여 건강 조심하라는 안부인사를 넣어줘q: 한글로 작성해줘.q: 세부사항 앞 [  ]이 공백이라면 메일에서 언급자체를하지 말아줘. 메일이 끝나면 end를 한번에 보내줘'
      }).toString();

      final sseClient = SseClient(url);
      sseClient.stream.listen((data) {
        if (data == 'end') {
          sseClient.close();
        } else {
          controller.add(data);
        }
      }, onError: (error) {
        print('Error: $error');
        controller.addError('Error: $error');
      }
      );
    } catch (e) {
      print('Exception: $e');
      controller.addError('Exception: $e');
    }

    return controller.stream;
  }
}
