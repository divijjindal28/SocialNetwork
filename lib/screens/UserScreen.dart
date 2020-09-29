import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("width    " + width.toString());

    return Scaffold(

      body:  Center(
          child: Container(
            width: width > 500 ? 500 : double.infinity,

            child :ListView.builder(
                itemCount: 10+1,
                itemBuilder: (ctx,index){
                  if(index == 0){
                    return UserDescription();
                  }
                  index =index-1;
                  return PostFrame();

                }

            ),

            ),
        ),









    );
  }
}