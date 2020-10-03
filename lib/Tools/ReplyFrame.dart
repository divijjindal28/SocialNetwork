import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/SendText.dart';

class ReplyFrame extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
      Card(
        child:  Padding(
            padding: EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.centerLeft,
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

                   Padding(
                      padding: EdgeInsets.all(2),
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ', style: TextStyle(
                      ),),
                    ),

                  feedbackRow(Icon(Icons.favorite_border), null,'likes', 7),
                ],
              ),
            )
        ),
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


