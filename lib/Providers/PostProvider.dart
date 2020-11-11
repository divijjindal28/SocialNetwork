import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Post extends ChangeNotifier {
  final post_id;
  final String userName;
  final String userId;
  String description;
  String image_url;
  bool like;
  int likes_count;
  int comments_count;
  int shares_count;
  List<Comment> comment_list;
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

  Future<void> sharePost(BuildContext context, bool currentUser, String postId,
      String description, String imagePath) async {
    try {
      String _tokenId = UserProvider.mainUser.tokenId;

      await Provider.of<PostProvider>(context, listen: false)
          .addPost(currentUser, description, imagePath);
      final response = await http.patch(
          'https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId',
          body: json.encode({
            'shareCount': (this.shares_count + 1).toString(),
          }));
      if (response.statusCode > 400) {
        throw HttpException("Something went wrong , Please try again.");
      } else {
        this.shares_count += 1;
      }
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addComment(
    String postId,
    String comment,
  ) async {
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try {
      final response = await http.post(
          'https://socialnetwork-fa878.firebaseio.com/posts/$postId/comments.json?auth=$_tokenId',
          body: json.encode({
            'comment': comment,
            'userName': _userName,
            'userId': _userId,
            'time': DateTime.now().toIso8601String()
          }));
      var _newComment = Comment(
          userId: _userId,
          userName: _userName,
          time: DateTime.now(),
          comment: comment,
          comment_id: json.decode(response.body)['name'].toString());
      this.comments_count += 1;
      comment_list.insert(0, _newComment);
      notifyListeners();
    } catch (err) {
      throw HttpException("Something went wrong , Please try again.");
    }
  }

  Future<void> updatePost(
    String postId,
    String description,
    String imageUrl,
  ) async {
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try {
      final response = await http.patch(
          'https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId',
          body: json.encode({
            'description': description,
            'imageUrl': imageUrl,
          }));
      if (response.statusCode > 400) {
        throw HttpException("Something went wrong , Please try again.");
      } else {
        this.description = description;
        this.image_url = imageUrl;
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();
    } catch (err) {
      throw HttpException("Something went wrong , Please try again.");
    }
  }

  Future<void> addTofav(String postId) async {
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try {
      final response = this.like == false
          ? await http.patch(
              'https://socialnetwork-fa878.firebaseio.com/posts/$postId/likes/$_userId.json?auth=$_tokenId',
              body: json.encode({'userName': _userName}))
          : await http.delete(
              'https://socialnetwork-fa878.firebaseio.com/posts/$postId/likes/$_userId.json?auth=$_tokenId');

      if (response.statusCode > 400) {
        throw HttpException(
            "Something went wrong. Error from server , Please try again.");
      } else if (response == null) {
        throw HttpException("Something went wrong , Please try again.");
      } else {
        this.like = !this.like;
        this.like == true ? this.likes_count += 1 : this.likes_count -= 1;
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();
    } catch (err) {
      throw HttpException("Something went wrong , Please try again.");
    }
  }
}

class PostProvider extends ChangeNotifier {
  List<Post> _myPosts = [];
  //final List<TimeLinePost> _timeleinePostsDetails = null;

  List<Post> get getMyPost {
    _myPosts.sort((a, b) => b.time.compareTo(a.time));
    return _myPosts;
  }

  Future<void> addPost(
    bool currentUser,
    String description,
    String imageUrl,
  ) async {
    String _userId = UserProvider.mainUser.userId;
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userName = UserProvider.mainUser.userName;

    try {
      final response = await http.post(
          'https://socialnetwork-fa878.firebaseio.com/posts.json?auth=$_tokenId',
          body: json.encode({
            'userName': _userName,
            'userId': _userId,
            'description': description,
            'imageUrl': imageUrl,
            'shareCount': "0",
            'time': DateTime.now().toIso8601String()
          }));
      var _newPost = Post(
          time: DateTime.now(),
          userId: _userId,
          userName: _userName,
          description: description,
          image_url: imageUrl,
          shares_count: 0,
          post_id: json.decode(response.body)['name'].toString());

      if (currentUser == true) {
        _myPosts.insert(0, _newPost);
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();
    } catch (err) {
      throw HttpException(
          "Something went wrong , Please try again." + err.toString());
    }
  }

  Future<List<Post>> getHomeScreenPosts() async {
    _myPosts = [];
    String _tokenId = UserProvider.mainUser.tokenId;
    String _userId = UserProvider.mainUser.userId;

    try {
      final response = await http.get(
          'https://socialnetwork-fa878.firebaseio.com/posts.json?auth=$_tokenId');
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        throw HttpException("Something went wrong , Please try again.");
      }
      if (extractedData['error'] != null) {
        throw HttpException("Something went wrong , Please try again." +
            extractedData['error'].toString());
      }

      extractedData.forEach((key, value) {
        int commentCount = 0;
        List<Comment> comments = [];

        if (value['comments'] != null) {
          value['comments'].forEach((cKey, cValue) {
            commentCount += 1;
            int replyCount = 0;
            List<Reply> replies = [];

            if (cValue['replies'] != null) {
              cValue['replies'].forEach((rKey, rValue) {
                bool like = false;
                int like_count = 0;
                replyCount += 1;

                if (rValue['likes'] != null)
                  rValue['likes'].forEach((rKey, rValue) {
                    like_count += 1;

                    if (rKey == _userId) like = true;
                  });

                replies.insert(
                    0,
                    Reply(
                        reply_id: rKey,
                        userId: rValue['userId'],
                        userName: rValue['userName'],
                        reply: rValue['reply'],
                        time: DateTime.parse(rValue['time']),
                        likes_count: like_count,
                        like: like));
              });
            }
            bool like = false;
            int like_count = 0;

            if (cValue['likes'] != null)
              cValue['likes'].forEach((cKey, cValue) {
                like_count += 1;

                if (cKey == _userId) like = true;
              });

            comments.insert(
                0,
                (Comment(
                    comment_id: cKey,
                    userId: cValue['userId'],
                    userName: cValue['userName'],
                    comment: cValue['comment'],
                    time: DateTime.parse(cValue['time']),
                    reply_list: cValue['replies'] == null ? [] : replies,
                    like: like,
                    likes_count: like_count,
                    reply_count: replyCount)));
          });
        }

        bool like = false;
        int like_count = 0;

        if (value['likes'] != null)
          value['likes'].forEach((lKey, lValue) {
            like_count += 1;
            if (lKey == _userId) like = true;
          });

        var _newPost = Post(
            time: DateTime.parse(value['time']),
            userId: value['userId'],
            userName: value['userName'],
            description: value['description'],
            comment_list: value['comments'] == null ? [] : comments,
            image_url: value['imageUrl'],
            like: like,
            shares_count: int.parse(value['shareCount']),
            likes_count: like_count,
            post_id: key,
            comments_count: commentCount);

        if (_newPost.userId == UserProvider.mainUser.userId) {
          _myPosts.insert(0, _newPost);
        } else {
          if (UserProvider.mainUser.following != []) {
            UserProvider.mainUser.following.forEach((element) {
              if (element.userId == _newPost.userId) {
                _myPosts.insert(0, _newPost);
              } else {}
            });
          }
        }
      });

      notifyListeners();
    } catch (err) {
      throw HttpException(
          "Something went wrong , Please try again." + err.toString());
    }
  }

  Future<List<Post>> getPost(String _userId) async {
    _myPosts = [];
    String _tokenId = UserProvider.mainUser.tokenId;

    try {
      final response = await http.get(
          'https://socialnetwork-fa878.firebaseio.com/posts.json?auth=$_tokenId&orderBy="userId"&equalTo="$_userId"');
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        throw HttpException("Something went wrong , Please try again.");
      }
      if (extractedData['error'] != null) {
        throw HttpException("Something went wrong , Please try again." +
            extractedData['error'].toString());
      }

      extractedData.forEach((key, value) {
        int commentCount = 0;
        List<Comment> comments = [];

        if (value['comments'] != null) {
          value['comments'].forEach((cKey, cValue) {
            commentCount += 1;
            int replyCount = 0;
            List<Reply> replies = [];

            if (cValue['replies'] != null) {
              cValue['replies'].forEach((rKey, rValue) {
                bool like = false;
                int like_count = 0;
                replyCount += 1;

                if (rValue['likes'] != null)
                  rValue['likes'].forEach((rKey, rValue) {
                    like_count += 1;

                    if (rKey == _userId) like = true;
                  });

                replies.insert(
                    0,
                    Reply(
                        reply_id: rKey,
                        userId: rValue['userId'],
                        userName: rValue['userName'],
                        reply: rValue['reply'],
                        time: DateTime.parse(rValue['time']),
                        likes_count: like_count,
                        like: like));
              });
            }
            bool like = false;
            int like_count = 0;

            if (cValue['likes'] != null)
              cValue['likes'].forEach((cKey, cValue) {
                like_count += 1;

                if (cKey == _userId) like = true;
              });

            comments.insert(
                0,
                (Comment(
                    comment_id: cKey,
                    userId: cValue['userId'],
                    userName: cValue['userName'],
                    comment: cValue['comment'],
                    time: DateTime.parse(cValue['time']),
                    reply_list: cValue['replies'] == null ? [] : replies,
                    like: like,
                    likes_count: like_count,
                    reply_count: replyCount)));
          });
        }

        bool like = false;
        int like_count = 0;

        if (value['likes'] != null)
          value['likes'].forEach((lKey, lValue) {
            like_count += 1;
            if (lKey == _userId) like = true;
          });

        var _newPost = Post(
            time: DateTime.parse(value['time']),
            userId: value['userId'],
            userName: value['userName'],
            description: value['description'],
            comment_list: value['comments'] == null ? [] : comments,
            image_url: value['imageUrl'],
            like: like,
            shares_count: int.parse(value['shareCount']),
            likes_count: like_count,
            post_id: key,
            comments_count: commentCount);
        _myPosts.insert(0, _newPost);
      });

      notifyListeners();
    } catch (err) {
      throw HttpException(
          "Something went wrong , Please try again." + err.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    String _tokenId = UserProvider.mainUser.tokenId;

    try {
      final response = await http.delete(
          'https://socialnetwork-fa878.firebaseio.com/posts/$postId.json?auth=$_tokenId');

      if (response.statusCode > 400) {
        throw HttpException("Something went wrong , Please try again.");
      } else {
        _myPosts.removeWhere((element) => element.post_id == postId);
      }
      //_myTimeLinePosts.insert(0, _newPost);
      notifyListeners();
    } catch (err) {
      throw HttpException("Something went wrong , Please try again.");
    }
  }
}
