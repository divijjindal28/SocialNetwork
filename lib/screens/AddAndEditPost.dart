
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';



class AddAndEditPost extends StatefulWidget {
  static const route  = './addandeditscreen';
  String networkImage = '';
  String description = '';
  TextEditingController descriptionController = TextEditingController();

  @override
  _AddAndEditPostState createState() => _AddAndEditPostState();
}

class _AddAndEditPostState extends State<AddAndEditPost> {
  File _image;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var _postProvider=Provider.of<PostProvider>(context);




    return Scaffold(
      appBar: AppBar(
        title: Text('Add / Edit Post'),
      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                          fit: FlexFit.tight,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: GestureDetector(
                              onTap: ()async{
                                final result =await  Navigator.of(context).pushNamed(ImageScreen.route);
                                setState(() {
                                  widget.networkImage = result;
                                  print("qwe"+widget.networkImage);
                                });
                              },

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,

                                  ),
                                  //child: Center(child:const Text('Add Image',style: TextStyle(color: Colors.white,fontSize: 18),)),
                                  child:widget.networkImage == '' ? Center(child: Text('+ Add Image',style: TextStyle(color: Colors.white,fontSize: 20),),):Image(
                                    image: NetworkImage(widget.networkImage),
                                    fit: BoxFit.contain,
                                  )
                                ),

                            ),
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,

                            child: TextFormField(
                              controller: widget.descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide()
                                )
                              ),
                              textInputAction: TextInputAction.done,
                              minLines: 2,
                              maxLines: 5,

                              onSaved: (value){
                                widget.descriptionController.text = value;

                              },

                            ),

                      )
                    ],
                  ),
                ),
                FlatButton(
                    minWidth: double.infinity,
                    onPressed:() async{
                      try{await _postProvider.addPost(widget.descriptionController.text, widget.networkImage);
                      Navigator.of(context).pop();
                      }
                      catch(error){print('post_error' + error.toString());}
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                )

              ],
            ),
        ),
      ),
    );
  }
}
