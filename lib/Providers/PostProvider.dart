import 'package:flutter/cupertino.dart';

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
  final user_id;
  final String name;
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
    @required this.user_id,
    @required this.name,
    @required this.description,
    @required this.image_url,
    @required this.likes_count,
    @required this.comments_count,
    @required this.shares_count,
    @required this.like,
    this.comment_list,
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
}