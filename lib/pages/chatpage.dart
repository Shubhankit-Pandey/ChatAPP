import 'package:chatapp/pages/signin.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import './group.dart';

class chatPage extends StatefulWidget {
  final token;
  const chatPage({@required this.token, super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  TextEditingController nameController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    String name;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Alert"),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Not proper";
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => {
                    print(nameController.text),
                    if (formKey.currentState!.validate())
                      {
                        name = email,
                        nameController.clear(),
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => groupPage(
                              uuid.v1(),
                              name,
                            ),
                          ),
                        ),
                      }
                  },
                  child: const Text("Enter"),
                )
              ],
            ),
          ),
          child: Text("start"),
        ),
      ),
    );
  }
}
