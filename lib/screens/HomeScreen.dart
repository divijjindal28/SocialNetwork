import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: (){},
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx,index){
            return PostFrame();

          }

          ),
    );
  }
}
