import 'package:flutter/material.dart';
import 'package:socialmediaapp/CustomPageTransitionBuilder.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/screens/AccountScreen.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:socialmediaapp/screens/AuthScreen.dart';
import 'package:socialmediaapp/screens/ChatUserScreen.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/TabScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PostProvider())

      ],
      child: MaterialApp(
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
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
              pageTransitionsTheme: PageTransitionsTheme( builders: {
                TargetPlatform.android:CustomPageTransitionBuilder(),
                TargetPlatform.iOS:CustomPageTransitionBuilder()
              })
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx,userSnap){
              if(userSnap.hasData){
                return TabScreen();
              }
              return AuthScreen();
            },
          ),
          routes: {
            AccountScreen.route :(_) => AccountScreen(homeScreen: false,),
            ChatUserScreen.route :(_) => ChatUserScreen(),
            AddAndEditPost.route :(_) => AddAndEditPost(),
            ImageScreen.route :(_) => ImageScreen(),
            PostScreen.route :(_) => PostScreen(),
            CommentScreen.route :(_) => CommentScreen(),
            UserScreen.route :(_) => UserScreen(),
          },

        ),
    );

  }
}


