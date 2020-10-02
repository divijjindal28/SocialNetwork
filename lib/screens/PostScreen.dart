import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,

          child: Column(
            children: <Widget>[
              PostFrame(),
              //CommentFrame()
            ],
          ),
        ),
      ),
    );
  }

