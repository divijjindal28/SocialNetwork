import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:provider/provider.dart';

class PostFrame extends StatelessWidget {
  bool commentWork;
  bool currentUser;
  var mypost;
  PostFrame({this.commentWork = true, this.currentUser = false});
  @override
  Widget build(BuildContext context) {
    void comment() {
      Navigator.of(context).pushNamed(PostScreen.route);
    }
    var _postProvider = Provider.of<PostProvider>(context,listen:false);
    mypost = Provider.of<Post>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UserScreen.route);
                  },
                  child: FittedBox(
                      child: Text(
                    mypost.userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              currentUser
                  ?
              DropdownButton(

                  icon:const Icon(Icons.more_horiz),
                  items: [
                    DropdownMenuItem(
                      child:const  Text('Edit'),
                      value: 'edit',
                    ),DropdownMenuItem(
                      child:const  Text('Delete'),
                      value: 'delete',
                    )
                  ],
                  onChanged: (value) async{
                    if (value == 'edit') {
                      Navigator.of(context).pushNamed(AddAndEditPost.route,arguments: {

                        'provider':mypost
                      });

                    }else
                    {
                      try{
                        await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(child: Text("Delete Post")),
                              content: Text("Do you really want to delete this post?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed:()async{await _postProvider.deletePost(mypost.post_id);Navigator.of(ctx).pop();},
                                    ),
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed:() => Navigator.of(ctx).pop(),
                                    )
                                  ],
                                )

                              ],
                            )
                        );

                      }catch(err){
                    MessegeBox.ShowError(
                    context: context,
                    msg: err.toString(),
                    intent: 'ERROR');
                    Navigator.of(context).pop(false);
                    }

                    }
                  })
                  : Container()
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
            child: Text(
                mypost.description),
          ),
        ),
        FadeInImage(
            placeholder:const AssetImage('assets/loading3.gif'),
            image: NetworkImage(mypost.image_url),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              feedbackRow(const Icon(Icons.favorite_border, color: Colors.grey),
                  null, 342),
              feedbackRow(const Icon(Icons.mode_comment, color: Colors.grey),
                  commentWork ? comment : null, 5),
              feedbackRow(const Icon(Icons.share, color: Colors.grey),null, 16)
            ],
          ),
        )
      ],
    );
  }

  Row feedbackRow(Icon icon, Function function, int count) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: function,
        ),
        Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
