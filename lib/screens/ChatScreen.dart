import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
          StreamBuilder(
            stream: Firestore.instance
                .collection('users/${UserProvider.mainUser.userId}/chats')
                .snapshots(),
            builder: (_,streamSnap){
              if(streamSnap.hasError){
                return Center(child: Text('Something went wrong. Please try again.'),);
              }
              if(streamSnap.data.documents.isEmpty){
                return Center(child: Text('No chats'),);
              }
              final document = streamSnap.data.documents;

              return ListView.builder(
                  itemCount: document.length > 0 ? document.length : 0,
                  itemBuilder: (ctx,index){
                    return Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.of(context).pushNamed(ChatUserScreen.route,arguments: {
                              'userName':document[index]['userName'],
                              'userImage':document[index]['userImage'],
                              'userId':document[index]['userId']
                            });
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(document[index]['userImage']),
                          ),
                          title: Text(document[index]['userName']),


                        ),
                        Divider()
                      ],
                    );
                  });
            },
          ),

    );
  }
}
