import 'dart:async';
import 'package:sse/client/sse_client.dart';
import 'package:menttang/src/data/baseUrl.dart';
import 'package:menttang/src/pages/automail_page.dart';

class DataFetcher {
  static Stream<String> fetchDataStream(String a1, String a2, String a3, String a4, String a5, String a6, String a7, String a8, String a9) {
    final controller = StreamController<String>();

    try {
      final url = Uri.parse(urlBase.url+'/chat-gpt/ask-stream/v1').replace(queryParameters:{
        'question': '너는 [$a1]이야. [$a2]께  [$a3]을 건으로 [$a4]를 설명하여 담아 연락처:[$a5] 를 메일 맨 끝에 포함하여 메일을 작성해줘.그리고 필요하다면 [$a6]에 대한 내용도 언급하여 추가해줘: [$a8] 말투로 작성해줘,q: 겨울에 관련하여 건강 조심하라는 안부인사를 넣어줘, q: language: 한국어, q: language:[$a7], q: 중간에 이모지를 [$a9] ,q: []로 되어있는 부분 안이 공백이라면 관련 부분은 메일에서 언급 자체를 하지 말아줘.  메일이 끝나면 end를 한번에 보내줘'
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

