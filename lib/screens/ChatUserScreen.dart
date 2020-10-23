import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/SendText.dart';


class ChatUserScreen extends StatelessWidget {
  static const route  = './chatUserScreen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('UserName'),

      ),
      body:Column(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        SendText('','Send Messege ..',2)
      ],) ,

    );
  }
}
