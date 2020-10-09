import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class CommentFrame extends StatelessWidget {

  bool replyWork;
  CommentFrame({this.replyWork = true});

  @override
  Widget build(BuildContext context) {
    void reply(){
      Navigator.of(context).pushNamed(CommentScreen.route);

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
                              child: Text('UserName', style: TextStyle(
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:const EdgeInsets.all(2),
                            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ', style: TextStyle(
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
                                    Text('7' +"  " +'likes', style: TextStyle(color:Colors.grey))),
                                feedbackRow(context, Icon(Icons.comment,color: Theme.of(context).accentColor),
                                    replyWork ? reply :null,
                                    Text('7' +"  " +'replies', style: TextStyle(color:Colors.grey))),
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


