import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/PostScreenContent.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {

  static const route = './post_screen';
  bool _isLoading = false;

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {

    Post post=  ModalRoute.of(context).settings.arguments;
    UserProvider.mainUser.currentPostId = post.post_id;

    Future<void> refresh()async{
      setState(() {
        widget._isLoading = true;
      });
      try{
        //await Provider.of<PostProvider>(context, listen: false).getPost();
      }catch(error){
        await MessegeBox.ShowError(context:context, intent:"ERROR");
      }
      setState(() {
        widget._isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.userName),

      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ChangeNotifierProvider.value(
          value: post,

          child:widget._isLoading? Center(child: CircularProgressIndicator(),): PostScreenContent()
        ),
      ),
    );
  }
}