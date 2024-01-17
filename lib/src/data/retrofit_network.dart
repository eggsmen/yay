import 'dart:async';
import 'package:sse/client/sse_client.dart';
import 'package:menttang/src/data/baseUrl.dart';
import 'package:menttang/src/pages/automail_page.dart';

class DataFetcher {
  static Stream<String> fetchDataStream(String a1, String a2, String a3, String a4, String a5, String a6) {
    final controller = StreamController<String>();

    try {
      final url = Uri.parse(urlBase.url+'/chat-gpt/ask-stream/v1').replace(queryParameters:{
        'question': '너는 [$a1]이야. [$a2]께  [$a3]을 건으로 [$a4]를 설명하여 담아 연락처:[$a5] 를 메일 맨 끝에 포함하여 메일을 작성해줘.그리고 필요하다면 [$a6]에 대한 내용도 언급하여 추가해줘: 친근한 말투로 작성해줘q: 겨울에 관련하여 건강 조심하라는 안부인사를 넣어줘q: 한글로 작성해줘. q: 세부사항 앞 [  ]이 공백이라면 메일에서 언급자체를하지 말아줘. 메일이 끝나면 end를 한번에 보내줘'
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
      });
    } catch (e) {
      print('Exception: $e');
      controller.addError('Exception: $e');
    }

    return controller.stream;
  }
}

