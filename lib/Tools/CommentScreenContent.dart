import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Tools/CommentFrame.dart';
import 'package:socialmediaapp/Tools/ReplyFrame.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:provider/provider.dart';

class CommentScreenContent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    var _comment = Provider.of<Comment>(context);
    _comment.reply_list =  _comment.reply_list == null ?  []: _comment.reply_list;
    return  Center(
      child: Container(
        width: width > 500 ? 500 : double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

        child: Card(
          elevation: 2,
          child: ListView.builder(
              itemCount:_comment.reply_list.length+1,

              itemBuilder: (ctx, index) {
                if(index == 0  ){
                  return Column(
                    children: <Widget>[
                      CommentFrame(replyWork: false,),
                      SendText(_comment.comment_id,'Type Reply',1)
                    ],
                  );

                }



                index =index-1;


                return
                _comment.reply_list.length== 0 ?
                Center(child:Text('No Replies.',style: TextStyle(color: Colors.black),)):
                ChangeNotifierProvider.value(
                    value:_comment.reply_list[index],
                    child: ReplyFrame(_comment.comment_id));
              }
          ),
        ),

      ),
    );
  }
}
