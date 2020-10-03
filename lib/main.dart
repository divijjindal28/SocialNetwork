import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/TabScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch:Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.deepPurple,
              textTheme: ButtonTextTheme.primary,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          )
      ),
      home: TabScreen(),
      routes: {
        PostScreen.route :(_) => PostScreen(),
        CommentScreen.route :(_) => CommentScreen(),
      },

    );
  }
}


