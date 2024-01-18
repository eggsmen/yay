
import 'package:flutter/material.dart';
import 'package:menttang/main.dart';
import 'package:menttang/src/data/UserService.dart';
import 'package:menttang/src/pages/sendMailSuccess.dart';


class SendMailPage extends StatelessWidget {
  final String liveData;
  final TextEditingController _toMailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  SendMailPage({Key? key, required this.liveData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메일 보내기'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2, // 화면의 2/3 영역 차지
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(liveData),
              ),
            ),
          ),
          Expanded(
            flex: 1, // 나머지 1/3 영역
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _toMailController,
                      decoration: InputDecoration(
                        labelText: '메일 주소',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => sendMail(
                      _toMailController.text,
                      context
                    ),
                    child: Text('전송'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );}

    Future<void> sendMail(
        String toMail,
        BuildContext context
        ) async {
      try {
        final response = await CustomMailSend.fetchData(
          toMail: _toMailController.text,
          subject: '대신 전해드립니다',
          content: liveData,
        );

        if (response.statusCode == 200) {
          // 성공 시 인증번호 대기 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SendMailSuccess()),
          );
        } else {
          // 실패 시 오류 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('메일 전송 실패: ${response.statusCode}')),
          );
        }
      } catch (e) {
        // 네트워크 오류 등의 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류 발생: $e')),
        );
      }
    }
  }




