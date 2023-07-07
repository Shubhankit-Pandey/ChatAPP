import 'dart:convert';

import 'package:chatapp/pages/signin.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'config.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonRes = jsonDecode(response.body);

      print(jsonRes['status']);

      if (jsonRes['status']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
      } else {
        print("something went wrong !!");
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
                colors: [
                  const Color(0XFFF95A3B),
                  Color.fromRGBO(171, 95, 95, 1)
                ],
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
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          // final data =
                          // ClipboardData(text: passwordController.text);
                          // Clipboard.setData(data);
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.password),
                        onPressed: () {
                          String passGen = generatePassword();
                          passwordController.text = passGen;
                          setState(() {});
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      print("clicked"),
                      registerUser(),
                    },
                    icon: Icon(Icons.app_registration),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     print("Sign In");
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => signIn(),
                  //       ),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';

  String password = '';

  int passLength = 20;

  String seed = upper + lower + numbers + symbols;

  List<String> list = seed.split('').toList();

  Random rand = Random();

  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}
