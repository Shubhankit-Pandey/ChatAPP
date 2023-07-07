import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/msgModel.dart';
import 'package:http/http.dart' as http;
import './config.dart';

class groupPage extends StatefulWidget {
  final String name;
  final String uid;
  final String userId;
  const groupPage(this.uid, this.name, this.userId, {super.key});

  @override
  State<groupPage> createState() => _groupPageState();
}

class _groupPageState extends State<groupPage> {
  List<MsgModel> listMsg = [];
  TextEditingController _msgcontroller = new TextEditingController();
  IO.Socket? socket;

  void addmessage() async {
    if (_msgcontroller.text.isNotEmpty) {
      var regBody = {"userId": widget.userId, "desc": _msgcontroller.text};
      var response = await http.post(Uri.parse(messagelink),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      // if(jsonResponse['status']){
      //   ms.clear();
      //   _todoTitle.clear();
      //   Navigator.pop(context);
      //   getTodoList(userId);
      // }else{
      //   print("SomeThing Went Wrong");
      // }
    }
  }

  void connect() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print("Connected to frontend");
      socket!.on(
        "sendMsgserver",
        (msg) {
          print(msg);
          if (msg["userId"] != widget.uid) {
            setState(() {
              listMsg.add(
                MsgModel(
                  msg: msg["msg"],
                  type: msg["type"],
                  sender: msg["sender"],
                ),
              );
            });
          }
        },
      );
    });
  }

  void sendMessage(String msg, String sender) {
    MsgModel ownmsg = MsgModel(msg: msg, type: "ownMsg", sender: sender);
    listMsg.add(ownmsg);
    setState(() {
      listMsg;
    });
    socket!.emit(
      'sendMsg',
      {
        "type": "ownMsg",
        "msg": msg,
        "sender": sender,
        "userId": widget.uid,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
      ),
      body: Column(
        children: [
          Expanded(
            // child: ListView(
            //   children: [
            //     OwnMessage("hello there", "shubh"),
            //     OtherMessage("message", "sender"),
            //   ],
            // ),
            child: ListView.builder(
                itemCount: listMsg.length,
                itemBuilder: (contex, index) {
                  if (listMsg[index].type == "ownMsg") {
                    return OwnMessage(
                        listMsg[index].msg, listMsg[index].sender);
                  } else {
                    return OtherMessage(
                        listMsg[index].msg, listMsg[index].sender);
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _msgcontroller,
                    decoration: const InputDecoration(
                      hintText: "Type here....",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    if (_msgcontroller.text.isNotEmpty)
                      {
                        sendMessage(_msgcontroller.text, widget.name),
                        addmessage(),
                        _msgcontroller.clear(),
                      }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OwnMessage extends StatelessWidget {
  final String message;
  final String sender;
  const OwnMessage(this.message, this.sender, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherMessage extends StatelessWidget {
  final String message;
  final String sender;
  const OtherMessage(this.message, this.sender, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
