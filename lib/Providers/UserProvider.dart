import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmediaapp/HtttpException.dart';

class FollowMap{
  final String userId;
  final String userName;
  final String userImageUrl;

  FollowMap({
    this.userId,
    this.userName,
    this.userImageUrl
});
}

class User{
  String currentPostId;
  final String userId;
  final String tokenId;
  final String userName;
  final String userImageUrl;
  List<FollowMap> followers;
  List<FollowMap> following;

  User({
      this.currentPostId = null,
      @required this.userId,
      @required this.tokenId,
      @required this.userName,
      this.userImageUrl = null,
      this.followers =null,
      this.following = null
  }
      );
}

class UserProvider  {
  static User mainUser;
  static User otherUser;

  static Future<void> getUserInfo()async{

    var user = await FirebaseAuth.instance.currentUser();
    String _userId = await user.uid;

    String _token;
    await user.getIdToken().then((result){
      _token =result.token;
    });

    try{

      var userData = await Firestore.instance.collection('users').document(_userId).get();
      var followersData = await Firestore.instance.collection('users/$_userId/Followers').getDocuments();
      var followingData = await Firestore.instance.collection('users/$_userId/Following').getDocuments();


      if(userData == null)
        {
          throw HttpException('User Does not exist2...please sign in again or check net connection ${_userId} hi');
        }

      List<FollowMap> followers = [];
      List<FollowMap> following = [];

      if(followersData!=null){
         followersData.documents.forEach((element) =>
          followers.insert(0, FollowMap(
            userImageUrl: element['imageUrl'],
            userName: element['name'],
            userId: element.documentID
          ))
      );}

      if(followingData!=null){
      followingData.documents.forEach((element) =>
          following.insert(0, FollowMap(
              userImageUrl: element['imageUrl'],
              userName: element['name'],
              userId: element.documentID
          ))
      );}

      print("bhai2" + followers.length.toString());
      print("bhai" + following.length.toString());
      mainUser = User(
        userId: _userId,
        tokenId: _token,
        userName: userData['userName'],
        userImageUrl: userData['userImage'],
        followers:followers ,
        following: following,

      );


//      var result = await http.get('https://socialnetwork-fa878.firebaseio.com/users/${_userId}.json?auth=$_token');
//      var Extractedmessege = json.decode(result.body);
//      mainUser = User(
//        userId: _userId,
//        tokenId: _token,
//        userName: Extractedmessege['userName'],
//        userImageUrl: Extractedmessege['userImageUrl'],
//        followers: Extractedmessege['followers'],
//      );
//
//      if(result.statusCode > 400){
//
//      }
    }catch(error){
      throw HttpException('User Does not exist...please sign in again or check net connection'+error.toString());
    }
  }


  }
