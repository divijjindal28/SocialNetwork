import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class ReplyFrame extends StatelessWidget {
  Reply reply;
  ReplyFrame(this.reply);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: ()      {Navigator.of(context).pushNamed(UserScreen.route);}
              ,
                        child: Padding(
                          padding:const EdgeInsets.all(2),

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(reply.userName, style: TextStyle(
                                  fontWeight: FontWeight.bold),),
                            ),

                        ),
                      ),

                       Padding(
                          padding:const EdgeInsets.all(2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(reply.reply, style: TextStyle(
                            ),),
                          ),
                        ),

                      feedbackRow(const Icon(Icons.favorite_border,color: Colors.red,), null,'likes', 7),
                    ],
                  ),
                )
            ),
          Divider()
        ],
      );


  }

  Row feedbackRow(Icon icon, Function function,String label, int count) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: null,

        ),
        Text(count.toString() +"  " +label, style: TextStyle(color: Colors.grey)),
        //Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }

}


