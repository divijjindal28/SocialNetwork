import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';


class AddAndEditPost extends StatefulWidget {
  static const route  = './addandeditscreen';

  @override
  _AddAndEditPostState createState() => _AddAndEditPostState();
}

class _AddAndEditPostState extends State<AddAndEditPost> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                              onTap: (){
                                Navigator.of(context).pushNamed(ImageScreen.route);
                              },
                              child: Hero(
                                tag: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,

                                  ),
                                  child: Center(child: Text('Add Image',style: TextStyle(color: Colors.white,fontSize: 18),)),
                                ),
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

                              },
                            ),

                      )
                    ],
                  ),
                ),
                FlatButton(minWidth: double.infinity,onPressed: (){}, child: Text('Submit',style: TextStyle(color: Theme.of(context).primaryColor),))

              ],
            ),
        ),
      ),
    );
  }
}
