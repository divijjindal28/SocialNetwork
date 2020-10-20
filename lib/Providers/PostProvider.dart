import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Reply{
  final reply_id;
  final String userName;
  final String reply;
  final bool like;
  final int likes_count;
  final DateTime time;

  Reply({
    this.reply_id,
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
  final String userName;
  final String comment;
  final bool like;
  final int likes_count;
  final int reply_count;
  final List<Reply> reply_list;
  final DateTime time;

  Comment({
    this.comment_id,
    this.userName,
    this.comment,
    this.like,
    this.likes_count,
    this.reply_count,
    this.reply_list,
    this.time
  }
      );

}

class Post extends ChangeNotifier{
  final post_id;
  final String userName;
  final String userId;
   String description;
   String image_url;
  final bool like;
  final int likes_count;
  final int comments_count;
  final int shares_count;
  final List<Reply> comment_list;
  final DateTime time;
  Post({

    @required this.post_id,
    @required this.userName,
    @required this.userId,
    @required this.description,
    @required this.image_url,
    this.likes_count = 0,
    this.comments_count = 0,
    this.shares_count = 0,
    this.like = false,
    this.comment_list = null,
    @required this.time,
  });

  Future<void> updatePost(String postId,String description,String imagePath,) async{

    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;
    String imageUrl;
    if(imagePath.contains('http')){
      imageUrl = imagePath;
    }else {
      try {
        final ref = FirebaseStorage.instance.ref().child('post_image').child(
            _userId + '-' + DateTime.now().toIso8601String() + ".jpg");
        await ref
            .putFile(File(imagePath))
            .onComplete;
        imageUrl = await ref.getDownloadURL();
      } on PlatformException catch (error) {
        var messege = 'Something went wrong, try after sometime.';
        if (error.message != null)
          messege = error.message;
        throw HttpException(messege);
      }
    }
    try{
      final response = await http.patch('https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId',body: json.encode({
        'description' : description,
        'imageUrl' : imageUrl,
      }));
      if(response.statusCode > 400)
        {
          throw HttpException("Something went wrong , Please try again.");
        }
      else {
        this.description = description;
        this.image_url = imageUrl;
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }

}

class TimeLinePost{
  final post_id;
  final user_id;
  final DateTime time;
  final List<String> comment_likes_id;
  final List<String> reply_likes_id;
  TimeLinePost({
    @required this.post_id,
    @required this.user_id,
    @required this.time,
    @required this.comment_likes_id,
    @required this.reply_likes_id,
});
}

class PostProvider extends ChangeNotifier{
  List<Post> _myPosts = [];
  //final List<TimeLinePost> _timeleinePostsDetails = null;
  final List<TimeLinePost> _myTimeLinePosts = null;

   List<Post> get getMyPost{
     _myPosts.sort((a,b) => b.time.compareTo(a.time));
    return _myPosts;
  }

  Future<void> addPost(String description,String imagePath,) async{

    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;
    String imageUrl;
    try{
      final ref =  FirebaseStorage.instance.ref().child('post_image').child(_userId +'-'+DateTime.now().toIso8601String()+ ".jpg");
      await ref.putFile(File(imagePath)).onComplete;
      imageUrl = await ref.getDownloadURL();
    }on PlatformException catch(error){
      var messege  = 'Something went wrong, try after sometime.';
      if(error.message!=null)
        messege = error.message;
      throw HttpException(messege);
    }

    try{


      final response = await http.post('https://socialnetwork-fa878.firebaseio.com/posts.json?auth=$_tokenId',body: json.encode({
      'userName': _userName,
      'userId': _userId,
      'description' : description,
      'imageUrl' : imageUrl,
      'time' : DateTime.now().toIso8601String()
    }));
      var _newPost = Post(
        time: DateTime.now(),
        userId: _userId,
        userName: _userName,
        description: description,
        image_url: imageUrl,
        post_id: json.decode(response.body)['name'].toString()
      );
      _myPosts.insert(0, _newPost);
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }

  Future<List<Post>> getPost() async{

    _myPosts = [];
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;
    String _userId = UserProvider.mainUser.userId;
    String imageUrl;

    try{
      final response = await http.get('https://socialnetwork-fa878.firebaseio.com/posts.json?auth=$_tokenId&orderBy="userId"&equalTo="$_userId"');
      var extractedData = json.decode(response.body) as Map<String,dynamic>;
      print("edata"+extractedData.toString());
      if(extractedData == null) {
        print("edata"+extractedData.toString());
        throw HttpException("Something went wrong , Please try again.1111");
      }
      if(extractedData['error'] != null) {
        print("xc1"+ extractedData['error']);
        throw HttpException("Something went wrong , Please try again2222." +
            extractedData['error'].toString());
      }
      extractedData.forEach((key, value) {
        var _newPost = Post(
            time:DateTime.parse(value['time']),
            userId: value['userId'],
            userName: value['userName'],
            description: value['description'],
            image_url: value['imageUrl'],
            post_id: key
        );
        _myPosts.insert(0, _newPost);
      });

      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again."+err.toString());
    }
  }

  Future<void> deletePost(String postId) async{

    String _tokenId = UserProvider.mainUser.tokenId;

    try{
      final response = await http.delete('https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId');

      if(response.statusCode > 400){
        throw HttpException("Something went wrong , Please try again.");
      }else{
      _myPosts.removeWhere((element) => element.post_id == postId);}
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }
}

