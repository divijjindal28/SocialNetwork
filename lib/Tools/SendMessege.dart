import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';


class SendMessege extends StatefulWidget {
  int type;
  String text;
  String id ;
  Map<String,dynamic> data;
  bool beforeChat;
  ChatUserScreenState parent;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();

  SendMessege(this.beforeChat,this.data,this.id,this.text,this.parent);
  @override
  _SendMessegeState createState() => _SendMessegeState();
}

class _SendMessegeState extends State<SendMessege> {

  var messages = '';
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void _onMessageSend()async{
      if(!widget._form.currentState.validate()){return;}
      setState(() {
        widget._isLoading = true;
      });
      try {


          if(widget.beforeChat == false) {
            await Firestore.instance.collection(
                'users/${UserProvider.mainUser.userId}/chats').add({
              'userId': widget.data['userId'],
              'userName': widget.data['userName'],
              'userImage': widget.data['userImage'],
            });


            final document = await Firestore.instance.collection(
                'users/${UserProvider.mainUser.userId}/chats').where('userId',isEqualTo: widget.data['userId']).getDocuments();
            widget.id = document.documents.first.documentID;
            await Firestore.instance.collection(
                'users/${widget.data['userId']}/chats').document(widget.id).setData({
              'userId': UserProvider.mainUser.userId,
              'userName': UserProvider.mainUser.userName,
              'userImage': UserProvider.mainUser.userImageUrl,
            });
            await Firestore.instance.collection('chats/${widget.id}/chat').add({
              'userId':UserProvider.mainUser.userId,
              'text': _controller.text,
              'time':DateTime.now().toIso8601String()
            });

            widget.parent.setState(() {

            });

            setState(() {
              widget.beforeChat = true;
            });
          }else{
          await Firestore.instance.collection('chats/${widget.id}/chat').add({
            'userId':UserProvider.mainUser.userId,
            'text': _controller.text,
            'time':DateTime.now().toIso8601String()
          });}



      }catch(error){
        MessegeBox.ShowError(context: context,msg: error.toString(),intent: "ERROR");
      }

      _controller.clear();
      setState(() {
        widget._isLoading = false;
      });
    }


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(25.0) //
          ),
        ),

        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                  key: widget._form,
                  child: TextFormField(

                    controller: _controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: widget.text),

                    validator:(val){
                      if(val.isEmpty){
                        return 'Plaese enter text';
                      }
                      else return null;
                    } ,
                    onSaved: (value){
                      setState(() {
                        _controller.text = value;
                      });
                    },
                  ),
                ),
              ),

            ),
            IconButton(icon: Icon(Icons.send,size: 25,color: widget._isLoading?Colors.black12:Colors.black,), onPressed:widget._isLoading?null: _onMessageSend)
          ],
        ),

      ),
    );
  }
}
