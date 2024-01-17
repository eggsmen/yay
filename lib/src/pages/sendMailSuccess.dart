import 'package:flutter/material.dart';

class SendMailSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메일 전송 완료'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/data_story_jeol_01.gif",
              height: 300.0,
              width: 300.0,
            ),
            SizedBox(height: 20),
            Text(
              '메일이 성공적으로 전송되었습니다!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
