import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
          itemCount: 10+1,
          itemBuilder: (ctx,index){
            if(index == 0){
              return UserDescription(currentUser: true,);
            }
            index =index-1;
            return Card(
                elevation: 4,
                child: PostFrame());

          }

      ),

    );
  }
}