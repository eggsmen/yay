import 'dart:async';
import 'package:sse/client/sse_client.dart';
import 'package:menttang/src/data/baseUrl.dart';

class DataFetcher {
  static Stream<String> fetchDataStream() {

    final controller = StreamController<String>();

    try {
      final url = Uri.parse(urlBase.url+'/chat-gpt/ask-stream/v1')
          .replace(queryParameters: {
        'question': '김태윤 교수님한테 정중하게 성적 정정 메일 써줘. 메일은 무조건 한국어로 써줘. 그리고 메일이 끝나면 end 를 한번에 보내줘.'
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
