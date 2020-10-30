import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddAndEditPost extends StatefulWidget {

  Post _post;
  bool _init = true;
  static const route = './addScreen';
  String _imagePath;
  String _imageUrl;
  String _postId = null;
  bool _loading = false;
  TextEditingController descriptionController = TextEditingController();
  @override
  _AddAndEditPostState createState() => _AddAndEditPostState();
}



class _AddAndEditPostState extends State<AddAndEditPost> {
  File _image;

  @override
  void didChangeDependencies() {
    if(widget._init){
      Map<String,dynamic> arg=  ModalRoute
          .of(context)
          .settings
          .arguments;
      if(arg!= null){
        widget._post = arg['provider'];
        widget._postId =  widget._post.post_id.toString();
        widget.descriptionController.text =  widget._post.description.toString();
        widget._imageUrl =  widget._post.image_url.toString();
      }
      widget._init = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var _postProvider = Provider.of<PostProvider>(context);

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
                            onTap: () async {
                              final result = await Navigator.of(context)
                                  .pushNamed(ImageScreen.route , arguments: false);
                              setState(() {
                                if(result!=null) {
                                  widget._imageUrl = result;

                                }
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                //child: Center(child:const Text('Add Image',style: TextStyle(color: Colors.white,fontSize: 18),)),
                                child:
                                        widget._imageUrl == null
                                    ? Center(
                                        child: Text(
                                          '+ Add Image',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                        : Image(
                                            image:
                                                NetworkImage(widget._imageUrl),
                                            fit: BoxFit.contain,
                                          )),
                          ),
                        )),
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
                                borderSide: BorderSide())),
                        textInputAction: TextInputAction.done,
                        minLines: 2,
                        maxLines: 5,
                        onSaved: (value) {
                          widget.descriptionController.text = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              widget._loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FlatButton(
                      minWidth: double.infinity,
                      onPressed: () async {
                        setState(() {
                          widget._loading = true;
                        });
                        try {
                          widget._postId == null ?
                          await _postProvider.addPost(
                              widget.descriptionController.text,
                              widget._imageUrl):
                          await widget._post.updatePost(
                              widget._postId,
                              widget.descriptionController.text,
                              widget._imageUrl);
                          Navigator.of(context).pop(true);
                        } catch (error) {
                          await MessegeBox.ShowError(
                              context: context,
                              msg: error.toString(),
                              intent: 'ERROR');
                          Navigator.of(context).pop(false);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
