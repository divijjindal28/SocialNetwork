import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';


class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
          ListView.builder(
              itemCount: 4,
              itemBuilder: (ctx,index){
                return Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Navigator.of(context).pushNamed(ChatUserScreen.route);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text('UserName'),
                      subtitle: Text('last chat'),

                    ),
                    Divider()
                  ],
                );
              }),

    );
  }
}
