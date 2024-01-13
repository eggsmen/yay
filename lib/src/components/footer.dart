import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Color(0xff6EA6E9)),
      alignment: Alignment.center,
      child: Text("Copy right 2024 YAY ALL Rights Reserved",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),textAlign: TextAlign.center ),
    );
  }
}
