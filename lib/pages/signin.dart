import 'dart:convert';
import 'package:chatapp/pages/splash.dart';
import './chatpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './signup.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonRes = jsonDecode(response.body);

      if (jsonRes['status']) {
        var myToken = jsonRes['token'];
        prefs.setString('token', myToken);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage(
              token: myToken,
            ),
          ),
        );
      } else {
        print("Something went wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color(0XFFF95A3B), const Color(0XFFF96713)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 0.8],
                tileMode: TileMode.mirror),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  IconButton(
                    onPressed: () {
                      loginUser();
                    },
                    icon: Icon(Icons.login),
                    // child: HStack([
                    //   VxBox(child: "LogIn".text.white.makeCentered().p16()).green600.roundedLg.make(),
                    // ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          },
          child: Container(
            height: 25,
            color: Colors.lightBlue,
            // child: Center(child: "Create a new Account..! Sign Up".text.white.makeCentered())),
          ),
        ),
      ),
    );
  }
}
