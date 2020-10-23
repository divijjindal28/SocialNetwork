import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/PostScreenContent.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {

  static const route = './post_screen';

  @override
  Widget build(BuildContext context) {

    Post post=  ModalRoute.of(context).settings.arguments;
    UserProvider.mainUser.currentPostId = post.post_id;
    return Scaffold(
      appBar: AppBar(
        title: Text(post.userName),

      ),
      body: ChangeNotifierProvider.value(
        value: post,

        child: PostScreenContent()
      ),
    );
  }


}