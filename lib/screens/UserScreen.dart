import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';

class UserScreen extends StatelessWidget {
  static const route = './userScreen';
  final bool currentUser;
  final bool homeScreen;
  UserScreen({this.currentUser = false,this.homeScreen = false});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar:homeScreen ? null : AppBar(
        title:const Text('Social Network')
      ),
      body:  Center(

          child: Container(
            width: width > 500 ? 500 : double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child :ListView.builder(
                itemCount: 10+1,
                itemBuilder: (ctx,index){
                  if(index == 0){
                    return UserDescription(currentUser: currentUser,);
                  }
                  index =index-1;
                  return Card(
                      elevation: 4,
                      child: PostFrame(currentUser: currentUser,));

                }

            ),

            ),
        ),
    );
  }
}