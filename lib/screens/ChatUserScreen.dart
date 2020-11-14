import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/SendMessege.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmediaapp/Tools/chatBubble.dart';

class ChatUserScreen extends StatefulWidget {
  static const route = './chatUserScreen';
  bool beforeChat;
  String id;
  @override
  ChatUserScreenState createState() => ChatUserScreenState();
}

class ChatUserScreenState extends State<ChatUserScreen> {
  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(data['userName']),
      ),
      body: FutureBuilder(
          future: Firestore.instance
              .collection('users/${UserProvider.mainUser.userId}/chats')
              .where('userId', isEqualTo: data['userId'])
              .getDocuments(),
          builder: (_, futureSnapshot) {
            if (futureSnapshot.hasError)
              return Center(
                child: Text('Something went wrong, please try again'),
              );
            else {
              if (!futureSnapshot.data.documents.isEmpty) {
                String chatId = futureSnapshot.data.documents.first.documentID;
                widget.id = chatId;
                widget.beforeChat = true;
              } else {
                widget.beforeChat = false;
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !futureSnapshot.data.documents.isEmpty
                            ? StreamBuilder(
                                stream: Firestore.instance
                                    .collection('chats/${widget.id}/chat')
                                    .orderBy('time')
                                    .snapshots(),
                                builder: (_, streamSnapshot) {
                                  final document =
                                      streamSnapshot.data.documents;
                                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

//                          document.length > 0
//                              ? beforeChat = true
//                              : beforeChat = false;
                                  return ListView.builder(
                                    controller: _scrollController,
                                      itemCount: document.length > 0
                                          ? document.length
                                          : 0,
                                      itemBuilder: (_, index) {
                                        print("length:" +
                                            document[index]['text']);
                                        return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: chatBubble(
                                                document[index]['userId'],
                                                document[index]['text']));
                                      });
                                },
                              )
                            : Container(
                                child: Center(
                                  child: Text('No messeges, say hi !!'),
                                ),
                              )),
                  ),
                  SendMessege(widget.beforeChat, data, widget.id,
                      'Send Messege ..', this)
                ],
              );
            }
          }),
    );
  }
}
