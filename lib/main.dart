



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menttang/src/home.dart';
import 'package:menttang/src/controller/screen_layout_controller.dart';
import 'package:menttang/src/data/UserService.dart'; // 가정한 import
import 'package:menttang/src/pages/VerificationPage.dart';
import 'package:menttang/src/pages/sendmailPage.dart'; // 가정한 import

int userId = 1 ;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("로그인", () => setState(() => isLogin = true)),
        SizedBox(height: 25),
        _buildButton("회원가입", () => setState(() => isSignUp = true)),
      ],
    );
  }

  Widget _buildLoginFields() {
    final double maxTextFieldWidth = 400.0;
    return Column(
      children: [
        Container(
          width: 400,
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: '이메일',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6EA6E9)), // 테두리 색상 설정
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 400,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '패스워드',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6EA6E9)), // 테두리 색상 설정
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildButton("로그인", _login),
      ],
    );
  }

  Future<void> _login() async {
    try {
      // UserService의 로그인 메서드를 호출하여 로그인 시도
      final response = await Login.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.statusCode == 200) {
        // 로그인 성공 시 HomePage로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // 로그인 실패 시 오류 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 실패: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // 네트워크 오류 등 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  Widget _buildSignUpFields() {
    final double maxTextFieldWidth = 400.0; // 가로 길이 상한선을 정하세요.

    return Column(
      children: [
        Container(
          width: maxTextFieldWidth,
          child: TextField(
            controller: _nicknameController,
            decoration: InputDecoration(
              labelText: '닉네임',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6EA6E9)), // 테두리 색상 설정
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10.0), // 패딩을 조절하세요.
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: maxTextFieldWidth,
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: '이메일',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6EA6E9)), // 테두리 색상 설정
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10.0), // 패딩을 조절하세요.
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: maxTextFieldWidth,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '패스워드',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6EA6E9)), // 테두리 색상 설정
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10.0), // 패딩을 조절하세요.
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildButton("회원가입", _signUp),
      ],
    );
  }


  Widget _buildButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(400, 48), // 버튼의 가로 길이와 높이를 조절하세요.
          primary: Color(0xff6EA6E9),    // 배경색을 파란색으로 설정하세요.
        ),
        child: Text(text,style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white ),),
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






