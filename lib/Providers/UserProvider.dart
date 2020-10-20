import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class User{
  final String userId;
  final String tokenId;
  final String userName;
  final String userImageUrl;
  final List<String> followers;

  User({
      @required this.userId,
      @required this.tokenId,
      @required this.userName,
      this.userImageUrl = null,
      this.followers = null,}
      );
}

class UserProvider  {
  static User mainUser;
  User otherUser;

  static Future<void> getUserInfo()async{

    var user = await FirebaseAuth.instance.currentUser();
    String _userId = await user.uid;

    String _token;
    await user.getIdToken().then((result){
      _token =result.token;
    });

    try{
      var result = await http.get('https://socialnetwork-fa878.firebaseio.com/users/${_userId}.json?auth=$_token');
      var Extractedmessege = json.decode(result.body);
      print("bhai mere"+Extractedmessege.toString());
      mainUser = User(
        userId: _userId,
        tokenId: _token,
        userName: Extractedmessege['userName'],
        userImageUrl: Extractedmessege['userImageUrl'],
        followers: Extractedmessege['followers'],
      );
      print('myresult' + json.decode(result.body)['userName'].toString());
      print('myresult2' + _userId);
      print('myresult3' + _token);

      if(result.statusCode > 400){

      }
    }catch(error){
      print('error1'+ error.toString());
    }
  }


  }
