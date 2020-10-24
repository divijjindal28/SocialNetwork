import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:socialmediaapp/HtttpException.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';

class Reply extends ChangeNotifier{
  final reply_id;
  final String userId;
  final String userName;
  final String reply;
   bool like;
   int likes_count;
  final DateTime time;

  Reply({
    @required this.reply_id,
    @required this.userId,
    @required this.userName,
    @required this.reply,
    this.like = false,
    this.likes_count = 0,
    @required  this.time
  }
      );
  Future<void> addTofav(String commentId,String replyId) async{

    String _currentPostId = UserProvider.mainUser.currentPostId;
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try{

      final response =
      this.like == false ?
      await http.patch('https://socialnetwork-fa878.firebaseio.com/posts/$_currentPostId/comments/$commentId/replies/$reply_id/likes/$_userId.json?auth=$_tokenId',body: json.encode({
        'userName' : _userName
      })):
      await http.delete('https://socialnetwork-fa878.firebaseio.com/posts/$_currentPostId/comments/$commentId/replies/$reply_id/likes/$_userId.json?auth=$_tokenId');

      if(response.statusCode > 400)
      {
        throw HttpException("Something went wrong. Error from server , Please try again.");
      }else if(response  ==null){
        throw HttpException("Something went wrong , Please try again.");
      }
      else {
        this.like = !this.like;
        this.like == true ?
        this.likes_count += 1:this.likes_count -= 1;
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again." );
    }
  }


}

class Comment extends ChangeNotifier{
  final comment_id;
  final String userId;
  final String userName;
  final String comment;
   bool like;
   int likes_count;
   int reply_count;
   List<Reply> reply_list;
  final DateTime time;

  Comment({
    @required this.comment_id,
    @required this.userId,
    @required this.userName,
    @required  this.comment,
    this.like = false,
    this.likes_count = 0,
    this.reply_count = 0,
    this.reply_list = null,
    @required this.time
  }
      );

  Future<void> addTofav(String commentId) async{

    String _currentPostId = UserProvider.mainUser.currentPostId;
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try{

      final response =
      this.like == false ?
      await http.patch('https://socialnetwork-fa878.firebaseio.com/posts/$_currentPostId/comments/$comment_id/likes/$_userId.json?auth=$_tokenId',body: json.encode({
        'userName' : _userName
      })):
      await http.delete('https://socialnetwork-fa878.firebaseio.com/posts/$_currentPostId/comments/$comment_id/likes/$_userId.json?auth=$_tokenId');

      if(response.statusCode > 400)
      {
        throw HttpException("Something went wrong. Error from server , Please try again.");
      }else if(response  ==null){
        throw HttpException("Something went wrong , Please try again.");
      }
      else {
        this.like = !this.like;
        this.like == true ?
        this.likes_count += 1:this.likes_count -= 1;
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again." );
    }
  }

  Future<void> addReply(String commentId,String reply,) async{

    String _currentPostId = UserProvider.mainUser.currentPostId;
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;


    try{


      final response = await http.post('https://socialnetwork-fa878.firebaseio.com/posts/$_currentPostId/comments/$comment_id/replies.json?auth=$_tokenId',body: json.encode({
        'reply': reply,
        'userName': _userName,
        'userId':_userId,
        'time' : DateTime.now().toIso8601String()
      }));
      var _newReply = Reply(
          userId: _userId,
          userName: _userName,
          time: DateTime.now(),
          reply: reply,
          reply_id: json.decode(response.body)['name'].toString(),
      );
      reply_list.insert(0, _newReply);
      this.reply_count += 1;
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }
}
