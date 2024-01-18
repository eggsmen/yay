import 'dart:async';
import 'package:sse/client/sse_client.dart';
import 'package:menttang/src/data/baseUrl.dart';
import 'package:menttang/src/pages/automail_page.dart';

class DataFetcher {
  static Stream<String> fetchDataStream(String a1, String a2, String a3, String a4, String a5, String a6, String a7, String a8, String a9) {
    final controller = StreamController<String>();

    try {
      final url = Uri.parse(urlBase.url+'/chat-gpt/ask-stream/v1').replace(queryParameters:{
        'question': '너가 [$a1]라고 고려해서 공손하게 메일을 쓰고, 메일을 다 쓴 후 맨 마지막에는 꼭 ^ 를 잊지말고 한번 단독으로 보내줘. 다른 말을 첨가하지 말고, 오로지 일반적인 메일처럼 메일 구성 내용 만을 보내줬으면 좋겠어. 메일 제목은 간결하고 핵심만 담기게 10글자 이내로 꼭 적어주고 메일의 시작내용은 메일 발신자를 소개하는걸로 시작해줘. 메일 수신자는 [$a2]이고, [$a3]을 용건으로 해서 [$a4]를 뒷받침으로 설명해줘. $a9가 없음이 아니라면 emoji를 메일 중간에 꼭! 여러개 붙여줘. emoji 양은 $a9 에 따라 꼭 조절해서 붙여줘. 연락처:[$a5]는 딱 한번만 적고 싶은데, 메일의 가장 마지막에 발신자를 적고 난 후에 연락처:[$a5]를 적어줘. [$a6]에 대한 내용도 자연스럽게 함께 넣어줘. 말투를 꼭! [$a8] 하여서 반영하고 default는 공손한 말투로 해줘. 겨울, 독감, 감기 등과 관련하여 안부인사를 메일 내용의 시작과 끝에 적절하고 배려 깊어보이게 많이 꼭! 넣어줘. 메일을 작성할 때 사용할 언어는 꼭 [$a7]로 전부 사용하고, default 값은 꼭 한국어로 해줘. []로 되어있는 부분 안이 공백이라면 관련 부분은 메일에서 언급 자체를 꼭! 아예 하지 말아줘. 그리고 잊지 말고 메일을 다 쓴 후 맨 마지막에는 꼭 ^ 를 한번만 단독으로 보내줘.'
      }).toString();

      final sseClient = SseClient(url);
      sseClient.stream.listen((data) {
        if (data == '^') {
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

