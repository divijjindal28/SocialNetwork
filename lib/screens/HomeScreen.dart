import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';

import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: (){Navigator.of(context).pushNamed(AddAndEditPost.route);},
      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx,index){
                return Card(
                    elevation: 4,
                    child: PostFrame()
                );
              }
              ),
        ),
      ),
    );
  }
}
