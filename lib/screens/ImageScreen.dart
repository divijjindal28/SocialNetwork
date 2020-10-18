import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ImageScreen extends StatefulWidget {
  static const route  = './imageScreen';
  bool _loading = false;
  File _image;
  String _imagePath = null;
  String networkImageUrl = '';
  String assetImageUrl = 'assets/add.png';
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title:Text('Image')
      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget._loading ? Center(child: CircularProgressIndicator()) : AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: 1,
                  child: Container(
                    height: 500,
                    child: GestureDetector(
                      onTap: ()async{
                          widget._imagePath = await MessegeBox.takeImage(context);
                        setState(() {

                        });


                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),

                          child:widget._imagePath == null ?
                          Center(child: Text('+ Add Image',style: TextStyle(color: Colors.white,fontSize: 20),),):
                          Image(

                            image: FileImage(File(widget._imagePath)),
                            fit: BoxFit.contain,
                          )
                      ),

                    ),
                      ),
                ),
              ),
              FlatButton(minWidth: double.infinity,onPressed: (){Navigator.of(context).pop(widget._imagePath);}, child: Text('Change Image',style: TextStyle(color: Theme.of(context).primaryColor),))
            ],
          ),
        ),
      ),
    );
  }
}
