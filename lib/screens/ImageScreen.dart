import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ImageScreen extends StatefulWidget {
  bool userImage = false;

  static const route  = './imageScreen';
  bool _loading = false;
  String _imagePath = null;
  String networkImageUrl = '';
  String assetImageUrl = 'assets/add.png';
  @override
  _ImageScreenState createState() => _ImageScreenState();
}


class _ImageScreenState extends State<ImageScreen> {
  bool init = false;

  @override
  void didChangeDependencies() {
    if(!init){
      widget. userImage = ModalRoute.of(context).settings.arguments;
      init= true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
               AspectRatio(
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
              widget._loading ? Center(child: CircularProgressIndicator()) :
              FlatButton(minWidth: double.infinity,onPressed: ()async{
                setState(() {
                  widget._loading = true;
                });
                String url = null;
                if(widget._imagePath != null) {
                  try{
                    final ref = FirebaseStorage.instance.ref().child(
                      widget.userImage ? 'userImage' : 'postImage').child(
                      widget.userImage ?
                      UserProvider.mainUser.userId+DateTime.now().toIso8601String() +  'user.jpg':
                      UserProvider.mainUser.userId+DateTime.now().toIso8601String() +'post.jpg');
                  await ref
                      .putFile(File(widget._imagePath))
                      .onComplete;

                   url = await ref.getDownloadURL();
                  
                  widget.userImage ?
                  await Firestore.instance.document(
                      'users/${UserProvider.mainUser.userId}')
                      .updateData({'userImage': url}):
                  null;

                  }catch(err){}


                }
                setState(() {
                  widget._loading = false;
                });
                Navigator.of(context).pop(url);

                }, child: Text('Change Image',style: TextStyle(color: Theme.of(context).primaryColor),))
            ],
          ),
        ),
      ),
    );
  }
}
