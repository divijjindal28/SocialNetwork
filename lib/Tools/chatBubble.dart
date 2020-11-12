import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';

class chatBubble extends StatelessWidget {
  String userId;
  String msg;
  chatBubble(this.userId, this.msg);
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Align(
          alignment: userId == UserProvider.mainUser.userId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: userId == UserProvider.mainUser.userId
                    ? Colors.black26
                    : Theme.of(context).primaryColor),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(msg,style: TextStyle(color:userId == UserProvider.mainUser.userId
                  ? Colors.black
                  :Colors.white, ),),
            ),
          ),
        ),
      ),
    );
  }
}
