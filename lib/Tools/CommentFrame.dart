import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:provider/provider.dart';

class CommentFrame extends StatelessWidget {

  bool replyWork;
  CommentFrame({this.replyWork = true});

  @override
  Widget build(BuildContext context) {
    var _comment = Provider.of<Comment>(context);
    void reply(){
      Navigator.of(context).pushNamed(CommentScreen.route ,arguments: _comment);

    }


    return
        Column(
          children: <Widget>[
            Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(UserScreen.route);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_comment.userName, style: TextStyle(
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:const EdgeInsets.all(2),
                            child: Text(_comment.comment, style: TextStyle(
                                ),),
                          ),
                        ),
                        Padding(
                            padding:const EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                feedbackRow(context,
                                    Icon(Icons.favorite_border,color: Colors.red),
                                    null,
                                    Text(_comment.likes_count.toString() +"  " +'likes', style: TextStyle(color:Colors.grey))),
                                feedbackRow(context, Icon(Icons.comment,color: Theme.of(context).accentColor),
                                    replyWork ? reply :null,
                                    Text(_comment.reply_count.toString() +"  " +'replies', style: TextStyle(color:Colors.grey))),
                              ],
                            )
                        ),
                      ],
                    )
                ),
            Divider()
          ],
        );


  }

  Row feedbackRow(BuildContext context,Icon icon, Function function,Text label) {
    return Row(
      children: <Widget>[
        FlatButton.icon(
          icon: icon,
          onPressed: function,
          label: label ,
        ),
        //Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }

}


