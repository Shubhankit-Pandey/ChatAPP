import 'package:flutter/material.dart';

import './signin.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _navigatetohome();
  // }

  // _navigatetohome() async {
  //   await Future.delayed(const Duration(milliseconds: 2000), () => {});
  //   Navigator.pushAndRemoveUntil(context,
  //       MaterialPageRoute(builder: (context) => SignInPage()), (route) => true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Splash Screen"),
          color: Colors.amber,
        ),
      ),
    );
  }
}
