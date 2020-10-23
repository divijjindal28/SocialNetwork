import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Tools/CommentFrame.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Tools/CommentScreenContent.dart';
import 'package:socialmediaapp/Tools/ReplyFrame.dart';
import 'package:socialmediaapp/Tools/SendText.dart';

class CommentScreen extends StatelessWidget {

  static const route = './comment_screen';

  @override
  Widget build(BuildContext context) {

    Comment _comment=  ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title:Text('Comment')
      ),
      body: ChangeNotifierProvider.value(
        value:_comment,
        child:CommentScreenContent()
      ),
    );
  }


}