import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';

class UserScreen extends StatelessWidget {
  static const route = './userScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
        title: Text('Social Network')
      ),
      body:  Center(

          child: Container(
            width: width > 500 ? 500 : double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child :ListView.builder(
                itemCount: 10+1,
                itemBuilder: (ctx,index){
                  if(index == 0){
                    return UserDescription();
                  }
                  index =index-1;
                  return Card(
                      elevation: 4,
                      child: PostFrame());

                }

            ),

            ),
        ),









    );
  }
}