import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Tools/CommentFrame.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/SendText.dart';

class PostScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Post _postData=  Provider.of<Post>(context);

    return  Center(
      child: Container(
        width: width > 500 ? 500 : double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Card(
          elevation: 2,
          child: ListView.builder(
              itemCount: _postData.comment_list.length +1,

              itemBuilder: (ctx, index) {
                if(index == 0  ){
                  return  Column(
                    children: <Widget>[
                      PostFrame(commentWork: false,),
                      SendText(_postData.post_id.toString(),'Type Comment',0),
                      Divider()
                    ],
                  );


                }
                index =index-1;
                return _postData.comment_list.length == 0 ?
                Center(child:Text('No comments.',style: TextStyle(color: Colors.black),)):
                ChangeNotifierProvider.value(
                    value:_postData.comment_list[index],
                    child: CommentFrame()
                );
              }
          ),
        ),

      ),
    );
  }
}
