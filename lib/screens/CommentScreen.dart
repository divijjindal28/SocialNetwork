import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/CommentFrame.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/ReplyFrame.dart';
import 'package:socialmediaapp/Tools/SendText.dart';

class CommentScreen extends StatelessWidget {

  static const route = './comment_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      appBar: AppBar(
        title:Text('Comment')
      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

            child: Card(
              elevation: 2,
              child: ListView.builder(
                  itemCount: 4 +1,

                  itemBuilder: (ctx, index) {
                    if(index == 0  ){
                      return Column(
                        children: <Widget>[
                          CommentFrame(replyWork: false,),
                          SendText('Type Reply',1)
                        ],
                      );

                    }



                    index =index-1;


                    return ReplyFrame();
                  }
              ),
            ),

        ),
      ),
    );
  }


}