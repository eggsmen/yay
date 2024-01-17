import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menttang/src/home.dart';
import 'package:menttang/src/controller/screen_layout_controller.dart';
import 'package:menttang/src/data/UserService.dart'; // 가정한 import
import 'package:menttang/src/pages/VerificationPage.dart'; // 가정한 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Y@Y!',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(ScreenLayoutController());
      }),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  bool isLogin = false;
  bool isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Widget _buildInitialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("로그인", () => setState(() => isLogin = true)),
        _buildButton("회원가입", () => setState(() => isSignUp = true)),
      ],
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: '이메일',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: '패스워드',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        _buildButton("로그인", () {
          // 로그인 로직 실행 및 성공적으로 완료되었을 때
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }),
      ],
    );
  }

  Widget _buildSignUpFields() {
    return Column(
      children: [
        TextField(
          controller: _nicknameController,
          decoration: InputDecoration(
            labelText: '닉네임',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: '이메일',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: '패스워드',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        _buildButton("회원가입", _signUp),
      ],
    );
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/img.png", width: 500),
            ),
            SizedBox(height: 20),
            if (isSignUp) _buildSignUpFields(),
            if (isLogin) _buildLoginFields(),
            if (!isLogin && !isSignUp) _buildInitialButtons(),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      final response = await DataFetcher.fetchData(
        email: _emailController.text,
        password: _passwordController.text,
        nickname: _nicknameController.text,
      );

      if (response.statusCode == 200) {
        // 성공 시 인증번호 대기 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage(email: _emailController.text)),
        );
      } else {
        // 실패 시 오류 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 실패: ${response.statusCode}')),
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






