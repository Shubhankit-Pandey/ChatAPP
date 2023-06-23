import 'package:chatapp/pages/signin.dart';
import 'package:flutter/material.dart';
import './group.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  TextEditingController nameController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                        name = nameController.text,
                        nameController.clear(),
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => groupPage(name),
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
