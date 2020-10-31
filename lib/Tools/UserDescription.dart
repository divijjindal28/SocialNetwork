import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDescription extends StatefulWidget {
   bool currentUser =false;
  Map<String,dynamic> data;
  UserDescription({this.currentUser = false,this.data = null});
  String _imageUrl ;
  String userName;
  String userId;
  @override
  _UserDescriptionState createState() => _UserDescriptionState();
}


class _UserDescriptionState extends State<UserDescription> {
  @override
  void initState() {
    widget._imageUrl = widget.currentUser ? UserProvider.mainUser.userImageUrl:widget.data['userImage'] ;
    widget.userName = widget.currentUser ? UserProvider.mainUser.userName:widget.data['userName'] ;
    widget.userId = widget.currentUser ? UserProvider.mainUser.userId:widget.data['userId'] ;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 4),
      constraints: BoxConstraints(
        maxHeight: 240
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Hero(
                          tag: widget.userId,
                          child: GestureDetector(
                            onTap: ()async{
                              if(widget.currentUser == true){
                              final result = await Navigator.of(context)
                                  .pushNamed(ImageScreen.route,arguments: true);
                              setState(() {
                                if(result!=null) {
                                  widget._imageUrl = result;

                                }
                              });
                              }else{null;}
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage:widget._imageUrl != null? NetworkImage(widget._imageUrl):null,
                              child:
                                  widget._imageUrl == null
                                  ? Center(
                                child: Text(
                                  '+ Add Image',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              )
                                  :null,
                              maxRadius: 70,

                              //should be image

                            ),
                          ),
                        ),

                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                          FittedBox(
                              child:  Text(widget.userName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ),)),
                      const SizedBox(height: 20,),
                      Column(
                        children: <Widget>[
                          const Text("Followers" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                           FittedBox(
                             child: Column(
                               children: <Widget>[
                                 Text("342",style: TextStyle( fontSize: 18),),
                               ],
                             ),
                           ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(

                child: RaisedButton(
                  child: Text(widget.currentUser?'LogOut': "Follow"),
                  onPressed: (){
                    widget.currentUser ?
                     logOut(context):

                        null;
                  },
                ),
              ),
              SizedBox(width: 10,),

              widget.currentUser?Container(): Expanded(
                child: RaisedButton(
                  child: Text("Messege"),
                  onPressed: (){
                    Navigator.of(context).pushNamed(ChatUserScreen.route);
                  },
                ),
              ),
            ],
          )
        ],

      ),
    );
  }

  Future logOut(BuildContext context) {
    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Center(child: Text('Logout')),
                        content: Text("Do you want to logOut?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Yes'),
                            onPressed:() {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(ctx).pop();},
                          ),
                          FlatButton(
                            child: Text('No'),
                            onPressed:() => Navigator.of(ctx).pop(),
                          )
                        ],
                      )
                  );
  }
}