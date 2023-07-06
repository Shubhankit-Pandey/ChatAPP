import 'package:chatapp/pages/signin.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:flutter/material.dart';

import './pages/splash.dart';
import './pages/chatpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}
