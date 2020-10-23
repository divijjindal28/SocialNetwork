import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:socialmediaapp/HtttpException.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';

class Reply{
  final reply_id;
  final String userId;
  final String userName;
  final String reply;
  final bool like;
  final int likes_count;
  final DateTime time;

  Reply({
    this.reply_id,
    this.userId,
    this.userName,
    this.reply,
    this.like,
    this.likes_count,
    this.time
  }
      );
}

class Comment extends ChangeNotifier{
  final comment_id;
  final String userId;
  final String userName;
  final String comment;
  final bool like;
  final int likes_count;
  final int reply_count;
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
          reply_id: json.decode(response.body)['name'].toString()
      );
      reply_list.insert(0, _newReply);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }
}

class CommentProvider extends ChangeNotifier{
  List<Comment> _myComments = [];
  //final List<TimeLinePost> _timeleinePostsDetails = null;

  List<Comment> get getMyPost{
    _myComments.sort((a,b) => b.time.compareTo(a.time));
    return _myComments;
  }






  Future<List<Comment>> getComment(String postId) async{

    _myComments = [];
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;
    String _userId = UserProvider.mainUser.userId;
    String imageUrl;

    try{
      final response = await http.get('https://socialnetwork-fa878.firebaseio.com/posts/$postId/comments.json?auth=$_tokenId');
      var extractedData = json.decode(response.body) as Map<String,dynamic>;
      if(extractedData == null) {
        throw HttpException("Something went wrong , Please try again");
      }
      if(extractedData['error'] != null) {
        throw HttpException("Something went wrong , Please try again" );
      }
      extractedData.forEach((key, value) {
        var _newPost = Comment(
            time:DateTime.parse(value['time']),
            userId: value['userId'],
            userName: value['userName'],
            comment: value['comment'],
            comment_id: key
        );
        _myComments.insert(0, _newPost);
      });

      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again."+err.toString());
    }
  }

//  Future<void> deletePost(String postId) async{
//
//    String _tokenId = UserProvider.mainUser.tokenId;
//
//    try{
//      final response = await http.delete('https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId');
//
//      if(response.statusCode > 400){
//        throw HttpException("Something went wrong , Please try again.");
//      }else{
//        _myPosts.removeWhere((element) => element.post_id == postId);}
//      //_myTimeLinePosts.insert(0, _newPost);
//      notifyListeners();
//
//    }catch(err){
//      throw HttpException("Something went wrong , Please try again.");
//    }
//  }
}