import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


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
  final String description;
  final String image_url;
  final bool like;
  final int likes_count;
  final int comments_count;
  final int shares_count;
  final List<Reply> comment_list;
  final DateTime time;
  Post({

    @required this.post_id,
    @required this.description,
    @required this.image_url,
    this.likes_count = 0,
    this.comments_count = 0,
    this.shares_count = 0,
    this.like = false,
    this.comment_list = null,
    @required this.time,
  });

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
  final List<Post> _posts = null;
  final List<TimeLinePost> _timeleinePostsDetails = null;
  final List<Post> _TimelinePosts = null;

  Future<void> addPost(String description,String imageUrl,String userId){
    http.post('https://socialnetwork-fa878.firebaseio.com/'+userId+'my_posts/'+'',body: json.encode({
      'description' : description,
      'imageUrl' : imageUrl,
      'time' : DateTime.now().toIso8601String()
    }));
  }
}