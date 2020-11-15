import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/PostScreenContent.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {

  static const route = './post_screen';
  bool _isLoading = false;
  bool _isLoading2 = false;

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {

    final data=  ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    Post post = data['post'];
    bool timeline = data['timeline'];
    UserProvider.mainUser.currentPostId = post.post_id;

    Future<void> refresh() async {
      setState(() {
        widget._isLoading2 = true;
      });
      try {
        print('timeline'+timeline.toString());
        timeline?
        await Provider.of<PostProvider>(context, listen: false)
            .getHomeScreenPosts()
            :
             await Provider.of<PostProvider>(context, listen: false)
            .getPost(post.userId);

      } catch (error) {
        await MessegeBox.ShowError(context: context, intent: "ERROR");
      }
      setState(() {
        widget._isLoading2 = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.userName),

      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child:widget._isLoading2? Center(child: CircularProgressIndicator(),):  ChangeNotifierProvider.value(
            value: post,

            child:widget._isLoading? Center(child: CircularProgressIndicator(),): PostScreenContent(parent: this,)
          ),
      ),

    );
  }
}