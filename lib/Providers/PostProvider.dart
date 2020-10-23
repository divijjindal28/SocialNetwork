import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';


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
  final List<Comment> comment_list;
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

  Future<void> addComment(String postId,String comment,) async{

    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;


    try{


      final response = await http.post('https://socialnetwork-fa878.firebaseio.com/posts/$postId/comments.json?auth=$_tokenId',body: json.encode({
        'comment': comment,
        'userName': _userName,
        'userId':_userId,
        'time' : DateTime.now().toIso8601String()
      }));
      var _newComment = Comment(
          userId: _userId,
          userName: _userName,
          time: DateTime.now(),
          comment: comment,
          comment_id: json.decode(response.body)['name'].toString()
      );
      comment_list.insert(0, _newComment);
      notifyListeners();

    }catch(err){
      throw HttpException("Something went wrong , Please try again.");
    }
  }

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

class PostProvider extends ChangeNotifier{
  List<Post> _myPosts = [];
  //final List<TimeLinePost> _timeleinePostsDetails = null;



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
      if(extractedData == null) {
        throw HttpException("Something went wrong , Please try again.");
      }
      if(extractedData['error'] != null) {
        throw HttpException("Something went wrong , Please try again." +
            extractedData['error'].toString());
      }
      print("EXTDATA" + extractedData.toString());
      extractedData.forEach((key, value) {
        print("EXTDATA2" + value.toString());


        List<Reply> replies =[];

        List<Comment> comments =[];
        if(value['comments'] != null)
        value['comments'].forEach((cKey, cValue) {
          replies = [];
          if(cValue['replies'] != null)
          cValue['replies'].forEach((rKey, rValue) {
            replies.insert(0, Reply(
              reply_id: rKey,
              userId: rValue['userId'],
              userName: rValue['userName'],
              reply: rValue['reply'],
              time: DateTime.parse(rValue['time']),

            ));
          });


          comments.insert(0, ( Comment(
            comment_id: cKey,
            userId: cValue['userId'],
            userName: cValue['userName'],
            comment: cValue['comment'],
            time: DateTime.parse(cValue['time']),
            reply_list:cValue['replies'] == null ? []:replies




          )));


        });

        var _newPost = Post(
            time:DateTime.parse(value['time']),
            userId: value['userId'],
            userName: value['userName'],
            description: value['description'],
            comment_list:value['comments'] == null ? []: comments,
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

