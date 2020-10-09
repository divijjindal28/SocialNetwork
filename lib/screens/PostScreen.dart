import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/CommentFrame.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/SendText.dart';

class PostScreen extends StatelessWidget {

  static const route = './post_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      appBar: AppBar(
        title: Text('Post Name'),

      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Card(
            elevation: 1,
            child: ListView.builder(
                    itemCount: 4 +1,

                    itemBuilder: (ctx, index) {
                      if(index == 0  ){
                        return Column(
                          children: <Widget>[
                            PostFrame(commentWork: false,),
                            SendText('Type Comment',0),
                            Divider()
                          ],
                        );

                      }
                      index =index-1;
                      return CommentFrame();
                    }
                ),
          ),

        ),
      ),
    );
  }


}