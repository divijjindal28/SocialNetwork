import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';

class CommentFrame extends StatelessWidget {

  bool replyWork;
  CommentFrame({this.replyWork = true});

  @override
  Widget build(BuildContext context) {
    void reply(){
      Navigator.of(context).pushNamed(CommentScreen.route);

    }
    return
        Card(
          child: InkWell(
            onTap: null,
            splashColor: Theme.of(context).primaryColor,
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('UserName', style: TextStyle(
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ', style: TextStyle(
                            ),),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            feedbackRow(Icon(Icons.favorite_border), null,'likes', 7),
                            feedbackRow(Icon(Icons.comment),
                                replyWork ? reply :null
                                ,'replies', 7),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ),
        );


  }

  Row feedbackRow(Icon icon, Function function,String label, int count) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: function,
        ),
        Text(count.toString() +"  " +label, style: TextStyle(color: Colors.grey)),
        //Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }

}


