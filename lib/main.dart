import 'package:flutter/material.dart';
import 'package:note_pad/modules/home/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

   //   InputDecoration.collapsed(hintText: 'Hello'),