import 'package:flutter/material.dart';

class Notification{
  final String userName;
  final String userId;
  final String postId;
  final String replyId;
  final bool request;
  final String action;
  final String imageUrl;

  Notification({
    @required this.userName,
    this.userId,
    this.postId,
    this.replyId,
    this.request,
    @required this.action,
    @required this.imageUrl
  });
}

class NotificationProvider extends ChangeNotifier{
  List<Notification> notifications = [
  ];
}