import 'package:chatapp/pages/signin.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/splash.dart';
import './pages/chatpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({@required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}
