import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';
import 'package:socialmediaapp/screens/FollowScreen.dart';
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
  List<FollowMap> _followers =[];
  List<FollowMap> _following =[];
  bool _isLoading = false;
  @override
  _UserDescriptionState createState() => _UserDescriptionState();
}


class _UserDescriptionState extends State<UserDescription> {
  @override
  void initState() {
    widget._imageUrl = widget.currentUser ? UserProvider.mainUser.userImageUrl:widget.data['userImage'] ;
    widget.userName = widget.currentUser ? UserProvider.mainUser.userName:widget.data['userName'] ;
    widget.userId = widget.currentUser ? UserProvider.mainUser.userId:widget.data['userId'] ;
    widget._followers = widget.currentUser ? UserProvider.mainUser.followers:widget.data['followers'] ;
    widget._following = widget.currentUser ? UserProvider.mainUser.following:widget.data['following'] ;
    // TODO: implement initState
    super.initState();
  }



  bool get isFriendCheck{
    if(UserProvider.mainUser.following != null ){
      if(!UserProvider.mainUser.following.isEmpty){
        if(UserProvider.mainUser.following.firstWhere((FollowMap element) => element.userId == widget.userId) != null){return true;}
        else{return false;}
      }else{return false;}
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    if(!widget.currentUser) {
    }

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
                          tag: widget.userId == null ? 1 : widget.userId,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                                child:  Text(widget.userName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18 ),)),
                          ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:()=> Navigator.of(context).pushNamed(FollowScreen.route , arguments: {
                              'heading':'Followers',
                              'followList':widget._followers
                            }),
                            child: Column(
                              children: <Widget>[
                                 Text(widget._followers.length.toString() , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                FittedBox(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Followers",style: TextStyle( fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: ()=> Navigator.of(context).pushNamed(FollowScreen.route , arguments: {
                          'heading':'Following',
                          'followList':widget._following
                          }),
                            child: Column(
                              children: <Widget>[
                                 Text(widget._following.length.toString() , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                 FittedBox(
                                   child: Column(
                                     children: <Widget>[
                                       Text("Following",style: TextStyle( fontSize: 15),),
                                     ],
                                   ),
                                 ),
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
                  child:widget._isLoading?Center(child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircularProgressIndicator(backgroundColor: Colors.white,),
                  ),) : Text(widget.currentUser?'LogOut':isFriendCheck ?"Unfollow" : "Follow"),
                  onPressed: ()async{

                    if(widget.currentUser == true)
                     {logOut(context);}
                    else{

                      if(!isFriendCheck) {
                        setState(() {
                          widget._isLoading=true;
                        });

                        await Firestore.instance.collection('users/${widget
                            .userId}/Followers').document(
                            UserProvider.mainUser.userId).setData(
                            {'name': UserProvider.mainUser.userName,
                              'imageUrl': UserProvider.mainUser.userImageUrl
                            });
                        await Firestore.instance.collection('users/${UserProvider.mainUser.userId}/Following').document(
                            widget.userId).setData(
                            {'name': widget.userName,
                              'imageUrl': widget._imageUrl
                            });
                        UserProvider.mainUser.following =[];
                        UserProvider.mainUser.following.add(FollowMap(
                          userId: widget.userId,
                          userName: widget.userName,
                          userImageUrl: widget._imageUrl
                        ));

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(
                              'You followed ${widget.userName}',
                              style: TextStyle(color: Colors.white),),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,));
                        setState(() {
                          widget._isLoading=false;
                        });
                      }else{
                        setState(() {
                          widget._isLoading=true;
                        });
                        await Firestore.instance.collection('users/${widget
                            .userId}/Followers').document(
                            UserProvider.mainUser.userId).delete();
                        await Firestore.instance.collection('users/${UserProvider.mainUser.userId}/Following').document(
                            widget.userId).delete();
                        UserProvider.mainUser.following.removeWhere((FollowMap element) => element.userId == widget.userId);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(
                              'You unfollowed ${widget.userName}',
                              style: TextStyle(color: Colors.white),),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,));
                        setState(() {
                          widget._isLoading=false;
                        });
                      }
                    }
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