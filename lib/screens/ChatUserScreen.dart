import 'package:flutter/material.dart';


class ChatUserScreen extends StatelessWidget {
  static const route  = './chatUserScreen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('UserName'),

      ),
      body:Column(children: <Widget>[
        //chats(),
        //newChat()
      ],) ,

    );
  }
}
