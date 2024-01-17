import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menttang/src/data/UserService.dart'; // 이 부분은 UserService의 정확한 구현에 따라 다를 수 있습니다.
import 'package:menttang/src/home.dart';

class VerificationPage extends StatelessWidget {
  final TextEditingController _verificationCodeController = TextEditingController();
  final String email;

  VerificationPage({Key? key, required this.email}) : super(key: key);

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('인증번호 확인')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/data_story_jeol_01.gif",
              height: 300.0,
              width: 300.0,
            ),
            Text('이메일: $email'),
            SizedBox(height: 10),
            TextField(
              controller: _verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '인증번호',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _buildButton("확인", () => _verifyAuth(context)),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyAuth(BuildContext context) async {
    try {
      final response = await checkAuth.fetchData( // UserService의 정확한 메소드 이름과 파라미터는 서비스 구현에 따라 다를 수 있습니다.
        email: email,
        authCode: _verificationCodeController.text,
      );

      if (response.statusCode == 200) {
        // 인증 성공 시 HomePage로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // 실패 시 오류 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 실패: ${response.statusCode}')),
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
