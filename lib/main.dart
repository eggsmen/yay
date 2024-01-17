import 'package:flutter/material.dart';
import 'package:menttang/src/home.dart';
import 'package:get/get.dart';
import 'package:menttang/src/controller/screen_layout_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Y@Y!',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      initialBinding: BindingsBuilder((){
        Get.put(ScreenLayoutController());
      }),
      home: HomePage(),

    );
  }
}

