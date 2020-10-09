import 'package:flutter/material.dart';
import 'package:socialmediaapp/CustomPageTransitionBuilder.dart';
import 'package:socialmediaapp/screens/AccountScreen.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:socialmediaapp/screens/AuthScreen.dart';
import 'package:socialmediaapp/screens/ChatScreen.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/SearchScreen.dart';
import 'package:socialmediaapp/screens/TabScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Social Network',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch:Colors.purple,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.deepPurple,
                textTheme: ButtonTextTheme.primary,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            pageTransitionsTheme: PageTransitionsTheme( builders: {
              TargetPlatform.android:CustomPageTransitionBuilder(),
              TargetPlatform.iOS:CustomPageTransitionBuilder()
            })
        ),
        home: TabScreen(),
        routes: {
          //SearchScreen.route :(_) => SearchScreen(),
          //ChatScreen.route :(_) => ChatScreen(),
          AccountScreen.route :(_) => AccountScreen(homeScreen: false,),
          ChatUserScreen.route :(_) => ChatUserScreen(),
          AddAndEditPost.route :(_) => AddAndEditPost(),
          ImageScreen.route :(_) => ImageScreen(),
          PostScreen.route :(_) => PostScreen(),
          CommentScreen.route :(_) => CommentScreen(),
          UserScreen.route :(_) => UserScreen(),
        },

      );

  }
}


